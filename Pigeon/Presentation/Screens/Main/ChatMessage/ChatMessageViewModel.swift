import Foundation

class ChatMessageViewModel {
    private let fetchUser: FetchUserUseCase = FetchUserUseCase(repository: UserRepositoryImpl())
    private let fetchCurentUser: FetchUserIdUseCase = FetchUserIdUseCase(repository: AuthRepositoryImpl())
    private let allFetchMessage: FetchAllMessagesUseCase = FetchAllMessagesUseCase(repository: MessageRepositoryImpl())
    private let observeChatMessages: ObserveMessagesUseCase = ObserveMessagesUseCase(repository: RealtimeMessageRepositoryImpl())
    private let fetchMessage: FetchMessageUseCase = FetchMessageUseCase(repository: MessageRepositoryImpl())
    private let creatChat: CreateChatUseCase = CreateChatUseCase(repository: ChatRepositoryImpl())
    private let addMessage: AddMessageUseCase = AddMessageUseCase(repository: MessageRepositoryImpl())
    private let sendMessage: SendMessageUseCase = SendMessageUseCase(repository: RealtimeMessageRepositoryImpl())
    private let appendMessageChat: AppendMessageToChatUseCase = AppendMessageToChatUseCase(repository: ChatRepositoryImpl())
    private let removeMessage: RemoveMessageUseCase = RemoveMessageUseCase(repository: RealtimeMessageRepositoryImpl())
    private let cleanOldMessages: CleanOldMessagesForSenderUseCase = CleanOldMessagesForSenderUseCase(repository: RealtimeMessageRepositoryImpl())

    var receiverFetched: ((UserCredentials) -> Void)?
    var fetchedChat: (([MessageCredentials]) ->Void)?
    var onNewMessageUpdate: ((MessageCredentials) -> Void)?
    var onShowError: ((Error) -> Void)?
    var fetchUserId: ((String) -> Void)?
    var onNewChat: ((ChatCredentials) -> Void)?
    var onMessageSent: (() -> Void)?

    func receiverUser(receiver_id: String){
        fetchUser.execute(uid: receiver_id) { [weak self] result in
            switch result {
            case .success(let receiver):
                self?.receiverFetched?(receiver)
            case .failure(let error):
                self?.onShowError?(error)
                print("Failed to fetch receiver user with ID \(receiver_id): \(error.localizedDescription)")
            }
        }
    }
    func fetchCurentUserId(){
        fetchCurentUser.execute {[weak self] result in
            switch result{
            case .success(let uid):
                self?.fetchUserId?(uid)
            case .failure(let error):
                self?.onShowError?(error)
                print("Failed to fetch current user ID: \(error.localizedDescription)")
            }
        }
    }
    func fetchAllMessages(chat: ChatCredentials){
        allFetchMessage.execute(for: chat) { [weak self] result in
            switch result {
            case .success(let chatMessages):
                self?.fetchedChat?(chatMessages)
            case .failure(let error):
                self?.onShowError?(error)
                print("Failed to fetch messages for chat \(chat.id ?? "nil"): \(error.localizedDescription)")
            }
        }
    }

    func observeMessage(chat: ChatCredentials){
        guard let chatID = chat.id else { return }
        observeChatMessages.execute(chatID: chatID) { [weak self] result in
            switch result {
            case .success(let message_id):
                self?.fetchMessage(message_id: message_id, chatID: chatID)
            case .failure(let error):
                self?.onShowError?(error)
                print("Failed to observe messages for chat \(chatID): \(error.localizedDescription)")
            }
        }
    }

    func fetchMessage(message_id: String, chatID: String){
        fetchMessage.execute(message_id: message_id) { [weak self] result in
            switch result {
            case .success(let message):
                self?.onNewMessageUpdate?(message)
                self?.removeMessage.execute(chatID: chatID, messageID: message_id) { _ in }
            case .failure(let error):
                self?.onShowError?(error)
                print("Failed to fetch message \(message_id): \(error.localizedDescription)")
            }
        }
    }

    func createChat(message: MessageCredentials){
        let chat_id = UUID().uuidString
        let created_at = Date()
        creatChat.execute(ChatCredentials(id: chat_id,user1_id: message.sender_id, user2_id: message.receiver_id, created_at: created_at, messages_ids: [])) { [weak self] result in
            switch result {
            case .success(let chat):
                var updatedMessage = message
                updatedMessage.chat_id = chat.id ?? chat_id
                self?.saveMessage(message: updatedMessage, chat: chat)
                self?.onNewChat?(chat)
            case .failure(let error):
                self?.onShowError?(error)
                print("Failed to create chat: \(error.localizedDescription)")
            }
        }
    }

    func sendMessages(message: MessageCredentials, chat: ChatCredentials?){
        if let chat = chat, let chatID = chat.id {
            var updatedMessage = message
            updatedMessage.chat_id = chatID
            saveMessage(message: updatedMessage, chat: chat)
        } else {
            self.createChat(message: message)
        }
    }

    func saveMessage(message: MessageCredentials, chat: ChatCredentials){
        addMessage.execute(message) { [weak self] result in
            switch result {
            case .success(let message):
                self?.appendMessageChat.execute(chat: chat, messageID: message.id!) { appendResult in
                    if case .failure(let error) = appendResult {
                        self?.onShowError?(error)
                        print("Failed to append message to chat: \(error.localizedDescription)")
                    }
                }
                self?.sendMessageRealtime(message: message)
            case .failure(let error):
                self?.onShowError?(error)
                print("Failed to add message to Firestore: \(error.localizedDescription)")
            }
        }
    }

    func sendMessageRealtime(message: MessageCredentials){
        sendMessage.execute(message) { [weak self] result in
            switch result {
            case .success:
                self?.onMessageSent?()
                DispatchQueue.main.asyncAfter(deadline: .now() + 20) {
                    self?.cleanOldMessages.execute(chatID: message.chat_id) { _ in }
                }
            case .failure(let error):
                self?.onShowError?(error)
                print("Failed to send realtime message: \(error.localizedDescription)")
            }
        }
    }
}
