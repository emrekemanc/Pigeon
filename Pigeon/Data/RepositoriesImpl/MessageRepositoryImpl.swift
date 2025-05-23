//
//  MessageRepositoryImpl.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 19.05.2025.
//

final class MessageRepositoryImpl: MessageRepository{
    private let messageService: MessageService = MessageService()
    func addMessage(_ message: MessageCredentials, completion: @escaping (Result<MessageCredentials, any Error>) -> Void) {
        messageService.addMessage(message, completion: completion)
    }
    
    func fetchAllMessages(for chat: ChatCredentials, completion: @escaping (Result<[MessageCredentials], any Error>) -> Void) {
        messageService.fetchAllMessages(for: chat, completion: completion)
    }
    
    func deleteMessage(withID id: String, completion: @escaping (Result<Bool, any Error>) -> Void) {
        messageService.deleteMessage(withID: id, completion: completion)
    }
    
    func deleteAllMessages(for chat: ChatCredentials, completion: @escaping (Result<Bool, any Error>) -> Void) {
        messageService.deleteAllMessages(for: chat, completion: completion)
    }
    
    func updateMessage(_ message: MessageCredentials, completion: @escaping (Result<MessageCredentials, any Error>) -> Void) {
        messageService.updateMessage(message, completion: completion)
    }
    func fetchMessage(message_id: String, completion: @escaping (Result<MessageCredentials,Error>) -> Void){
        messageService.fetchMessage(message_id: message_id, completion: completion)
    }
  
   
    
    
}
