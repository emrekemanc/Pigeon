//
//  RealtimeMessageRepositoryImpl.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 20.05.2025.
//

final class RealtimeMessageRepositoryImpl: RealtimeMessageRepository{
    private let realTimeMessageService: RealtimeMessageService = RealtimeMessageService()
    func sendMessage(_ message: MessageCredentials, completion: @escaping (Result<Bool, any Error>) -> Void) {
        realTimeMessageService.sendMessage(message, completion: completion)
    }
    
    func observeMessages(chatID: String, onNewMessage: @escaping (Result<String, any Error>) -> Void) {
        realTimeMessageService.observeMessages(chatID: chatID, onNewMessage: onNewMessage)
    }
    
    func removeMessage(chatID: String, messageID: String, completion: @escaping (Result<Bool, any Error>) -> Void) {
        realTimeMessageService.removeMessage(chatID: chatID, messageID: messageID, completion: completion)
    }
    
    func cleanOldMessagesForSender(chatID: String, completion: ((Result<Bool, any Error>) -> Void)?) {
        realTimeMessageService.cleanOldMessagesForSender(chatID: chatID, completion: completion)
    }
    
  

    
}
