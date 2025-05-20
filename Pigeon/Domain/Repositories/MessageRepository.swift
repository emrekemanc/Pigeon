//
//  MessageRepository.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 19.05.2025.
//

protocol MessageRepository{
    func sendMessage(_ message: MessageCredentials, completion: @escaping (Result<MessageCredentials, Error>) -> Void)
    func fetchMessages(for chat: ChatCredentials, completion: @escaping (Result<[MessageCredentials], Error>) -> Void) 
}
