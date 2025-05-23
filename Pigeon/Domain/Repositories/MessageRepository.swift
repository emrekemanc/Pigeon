//
//  MessageRepository.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 19.05.2025.
//

protocol MessageRepository{
    func addMessage(_ message: MessageCredentials, completion: @escaping (Result<MessageCredentials, Error>) -> Void) 
    func fetchAllMessages(for chat: ChatCredentials, completion: @escaping (Result<[MessageCredentials], Error>) -> Void)
    func deleteMessage(withID id: String, completion: @escaping (Result<Bool, Error>) -> Void)
    func deleteAllMessages(for chat: ChatCredentials, completion: @escaping (Result<Bool, Error>) -> Void)
    func updateMessage(_ message: MessageCredentials, completion: @escaping (Result<MessageCredentials, Error>) -> Void)
    func fetchMessage(message_id: String, completion: @escaping (Result<MessageCredentials,Error>) -> Void)
}
