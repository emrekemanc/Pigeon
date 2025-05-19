//
//  MessageRepositoryImpl.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 19.05.2025.
//

final class MessageRepositoryImpl: MessageRepository{
    private let messageService: MessageService = MessageService()
    func sendMessage(_ message: MessageCredentials, completion: @escaping (Result<Bool, any Error>) -> Void) {
        messageService.sendMessage(message, completion: completion)
    }
    
    func observeMessages(chatID: String, completion: @escaping (Result<MessageCredentials, any Error>) -> Void) {
        messageService.observeMessages(chatID: chatID, completion: completion)
    }
    
    func removeObservers(chatID: String) {
        messageService.removeObservers(chatID: chatID)
    }
    
    
}
