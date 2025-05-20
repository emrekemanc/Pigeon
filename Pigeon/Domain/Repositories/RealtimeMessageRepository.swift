//
//  RealtimeMessageRepository.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 20.05.2025.
//

protocol RealtimeMessageRepository{
    func sendRealtimeMessage(_ message: MessageCredentials, completion: @escaping (Result<Bool, Error>) -> Void)
    func observeMessages(chatID: String, onNewMessage: @escaping (Result<MessageCredentials, Error>) -> Void)
    func removeObservers(forChatID chatID: String)
}
