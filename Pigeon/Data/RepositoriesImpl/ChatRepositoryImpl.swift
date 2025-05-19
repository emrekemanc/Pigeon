//
//  ChatRepositoryImpl.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 19.05.2025.
//

final class ChatRepositoryImpl: ChatRepository{
    private let chatService: ChatService = ChatService()
    func createChatIfNeeded(user1ID: String, user2ID: String, completion: @escaping (Result<ChatCredentials, any Error>) -> Void) {
        chatService.createChatIfNeeded(user1ID: user1ID, user2ID: user2ID, completion: completion)
    }
    
    func fetchChat(by id: String, completion: @escaping (Result<ChatCredentials, any Error>) -> Void) {
        chatService.fetchChat(by: id, completion: completion)
    }
    
    
}
