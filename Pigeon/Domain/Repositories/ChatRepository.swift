//
//  ChatRepository.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 19.05.2025.
//

protocol ChatRepository{
    func createChatIfNeeded(user1ID: String, user2ID: String, completion: @escaping (Result<ChatCredentials, Error>) -> Void)
    func fetchChat(by id: String, completion: @escaping (Result<ChatCredentials, Error>) -> Void)
}
