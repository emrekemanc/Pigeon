//
//  RealtimeMessageRepository.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 20.05.2025.
//

protocol RealtimeMessageRepository{
    func sendMessage(_ message: MessageCredentials, completion: @escaping (Result<Bool, Error>) -> Void) 
    func observeMessages(chatID: String, onNewMessage: @escaping (Result<String, Error>) -> Void)
    func removeMessage(chatID: String, messageID: String, completion: @escaping (Result<Bool, Error>) -> Void)
    func cleanOldMessagesForSender(chatID: String, completion: ((Result<Bool, Error>) -> Void)?)
}
