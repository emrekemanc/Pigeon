import Foundation
class ChatMessageViewModel {
    private let sendMessageUseCase: SendMessageUseCase = SendMessageUseCase(repository: MessageRepositoryImpl())
    private let fetchUserIdUseCase: FetchUserIdUseCase = FetchUserIdUseCase(repository: AuthRepositoryImpl())
    private let observeMessagesUseCase: ObserveMessagesUseCase = ObserveMessagesUseCase(repository: RealtimeMessageRepositoryImpl())
    private let realTimeSendMessage: SendRealtimeMessageUseCase = SendRealtimeMessageUseCase(repository: RealtimeMessageRepositoryImpl())
    private let createChatUseCase: CreateChatUseCase = CreateChatUseCase(repository: ChatRepositoryImpl())
    private let appendMessageToChatUseCase: AppendMessageToChatUseCase = AppendMessageToChatUseCase(repository: ChatRepositoryImpl())
    
    private(set) var messages: [MessageCredentials] = []

    var onMessageUpdate: (() -> Void)?
    var onShowError: ((Error) -> Void)?
    var fetchUserId: ((String) -> Void)?
    var onNewChat: ((ChatCredentials) -> Void)?
    var onMessageSent: (() -> Void)?
    
    // Send a message to a receiver, optionally within an existing chat
    func sendMessage(text: String, to receiverID: String, chat: ChatCredentials?) {
        fetchUserIdUseCase.execute { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let senderID):
                self.processMessageSend(senderID: senderID, receiverID: receiverID, text: text, chat: chat)
            case .failure(let error):
                self.handleError(error)
            }
        }
    }
    
    func startObservingMessages(chat: ChatCredentials) {
        guard let id = chat.id else { return }
        observeMessagesUseCase.execute(chatID: id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let message):
                self.appendMessageAndNotify(message)
            case .failure(let error):
                self.handleError(error)
            }
        }
    }

    func fetchUserSelfId() {
        fetchUserIdUseCase.execute { result in
            switch result {
            case .success(let uid):
                self.fetchUserId?(uid)
            case .failure(let error):
                self.onShowError?(error)
            }
        }
    }

    // Decide whether to send message in existing chat or create a new chat first
    private func processMessageSend(senderID: String,receiverID: String,text: String,chat: ChatCredentials?) {
        let messageID = UUID().uuidString
        let timestamp = Date()
        if let existingChat = chat {
            sendMessageInExistingChat(messageID: messageID,chatID: existingChat.id ?? "",senderID: senderID,receiverID: receiverID,text: text,date: timestamp,chat: existingChat)
        } else {
            createNewChatAndSendMessage(messageID: messageID,senderID: senderID,receiverID: receiverID,text: text,timestamp: timestamp)
        }
    }

    // Send message in an existing chat and then send realtime notification
    private func sendMessageInExistingChat(messageID: String,chatID: String,senderID: String,receiverID: String,text: String,date: Date,chat: ChatCredentials) {
        let message = buildMessage(id: messageID,chatID: chatID,senderID: senderID,receiverID: receiverID,text: text,date: date)
        
        // Save message to the database
        sendMessageUseCase.execute(message) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                // Send realtime message notification
                self.realTimeSendMessage.execute(message) { realtimeResult in
                    switch realtimeResult {
                    case .success:
                        print("Realtime message sent")
                        self.onMessageSent?()
                    case .failure(let error):
                        self.handleError(error)
                    }
                }
            case .failure(let error):
                self.handleError(error)
            }
        }
    }

    // Create a new chat in Firestore and then send the first message
    private func createNewChatAndSendMessage(messageID: String,senderID: String,receiverID: String,text: String,timestamp: Date) {
        // Build new chat object with participants and timestamp
        let newChat = ChatCredentials(
            user1_id: senderID,
            user2_id: receiverID,
            created_at: timestamp,
            messages_ids: []
        )

        // Save the new chat to Firestore
        createChatUseCase.execute(newChat) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let createdChat):
                // Notify about new chat creation
                self.onNewChat?(createdChat)
                // Send message inside the newly created chat
                self.sendMessageInExistingChat(
                    messageID: messageID,
                    chatID: createdChat.id ?? "",
                    senderID: senderID,
                    receiverID: receiverID,
                    text: text,
                    date: timestamp,
                    chat: createdChat
                )
            case .failure(let error):
                self.handleError(error)
            }
        }
    }

    // Build message object with necessary details
    private func buildMessage(id: String,chatID: String,senderID: String,receiverID: String,text: String,date: Date) -> MessageCredentials {
        
        return MessageCredentials(
            id: id,
            chat_id: chatID,
            sender_id: senderID,
            receiver_id: receiverID,
            text: text,
            created_at: date,
            is_read: false
        )
    }

    // Add message ID to chat and append message to local list, then update UI
    private func appendMessageAndNotify(_ message: MessageCredentials) {
        guard !self.messages.contains(where: { $0.id == message.id }) else { return }

        self.messages.append(message)
        self.messages.sort { $0.created_at < $1.created_at }
        self.onMessageUpdate?()
    }

    private func handleError(_ error: Error) {
        self.onShowError?(error)
    }
}
