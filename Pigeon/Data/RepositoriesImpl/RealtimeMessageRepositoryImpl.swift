//
//  RealtimeMessageRepositoryImpl.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 20.05.2025.
//

final class RealtimeMessageRepositoryImpl: RealtimeMessageRepository{
    private let realTimeMessageService: RealtimeMessageService = RealtimeMessageService()
    func sendRealtimeMessage(_ message: MessageCredentials, completion: @escaping (Result<Bool, any Error>) -> Void) {
        realTimeMessageService.sendRealtimeMessage(message, completion: completion)
    }
    
    func observeMessages(chatID: String, onNewMessage: @escaping (Result<MessageCredentials, any Error>) -> Void) {
        realTimeMessageService.observeMessages(chatID: chatID, onNewMessage: onNewMessage)
    }
    func removeObservers(forChatID chatID: String){
        realTimeMessageService.removeObservers(forChatID: chatID)
    }
   
    
}
