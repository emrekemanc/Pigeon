//
//  ChatMessageViewModel.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 16.05.2025.
//

class ChatMessageViewModel{
    private let sendMessageUseCase: SendMessageUseCase = SendMessageUseCase(repository: MessageRepositoryImpl())
    private let observeMessagesUseCase: ObserveMessagesUseCase = ObserveMessagesUseCase(repository: MessageRepositoryImpl())
    private let removeObserversUseCase: RemoveObserversUseCase = RemoveObserversUseCase(repository: MessageRepositoryImpl())
    private let fetchUserIdUseCase: FetchUserIdUseCase = FetchUserIdUseCase(repository: AuthRepositoryImpl())
    private(set) var messages: [MessageCredentials] = []
    var onMessageUpdate: (() -> Void)?
    var onShowError: ((Error) -> Void)?
    func sendMessage(message: MessageCredentials){
       fetchId(message: message)
    }
   private func fetchId(message: MessageCredentials){
        fetchUserIdUseCase.execute { result in
            switch result{
            case .success(let uid):
                var updateMessage = message
                updateMessage.id = uid
                if updateMessage.chat_id == nil {
                    let chat_id = self.createChatId()
                    guard let id = chat_id else {return}
                    updateMessage.chat_id = id
                }
                self.sendSection(message: updateMessage)
            case .failure(let error):
                self.onShowError?(error)
            }
        }
    }
    
    private func createChatId() -> String?{
        
    }
    
   private func sendSection(message: MessageCredentials){
        sendMessageUseCase.execute(message) { result in
            switch result{
            case .success(let answer):
                self.onMessageUpdate?()
            case .failure(let error):
                self.onShowError?(error)
            }
        }
    }
    func listenMessages(chatId: String){
        observeMessagesUseCase.execute(chatID: chatId) { result in
            switch result{
            case .success(let answer):
                self.messages.append(answer)
                self.onMessageUpdate?()
            case .failure(let error):
                self.onShowError?(error)
            }
        }
        
    }
}
