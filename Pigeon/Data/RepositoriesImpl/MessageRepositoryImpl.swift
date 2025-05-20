//
//  MessageRepositoryImpl.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 19.05.2025.
//

final class MessageRepositoryImpl: MessageRepository{
    private let messageService: MessageService = MessageService()
   
    func sendMessage(_ message: MessageCredentials, completion: @escaping (Result<MessageCredentials, any Error>) -> Void) {
        messageService.sendMessage(message, completion: completion)
    }
    
    func fetchMessages(for chat: ChatCredentials, completion: @escaping (Result<[MessageCredentials], any Error>) -> Void) {
        messageService.fetchMessages(for: chat, completion: completion)
    }
    
}
