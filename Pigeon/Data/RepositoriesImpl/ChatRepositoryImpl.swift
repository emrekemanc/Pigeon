//
//  ChatRepositoryImpl.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 19.05.2025.
//

final class ChatRepositoryImpl: ChatRepository {
    private let chatService: ChatService = ChatService()
    func createChat(_ chat: ChatCredentials, completion: @escaping (Result<ChatCredentials, any Error>) -> Void) {
        chatService.createChat(chat, completion: completion)
    }
    
    func fetchChat(by chatID: String, completion: @escaping (Result<ChatCredentials, any Error>) -> Void) {
        chatService.fetchChat(by: chatID, completion: completion)
    }
    
    func checkIfChatExists(between chat: ChatCredentials, completion: @escaping (Result<ChatCredentials?, any Error>) -> Void) {
        chatService.checkIfChatExists(between: chat, completion: completion)
    }
    
    func appendMessageToChat(chat: ChatCredentials, messageID: String, completion: @escaping (Result<Bool, any Error>) -> Void) {
        chatService.appendMessageToChat(chat: chat, messageID: messageID, completion: completion)
    }
    
    func fetchUserChatIDs(userID: String, completion: @escaping (Result<[String], Error>) -> Void) {
        chatService.fetchUserChatIDs(userID: userID, completion: completion)
    }
    func addChatIDToUsers(chatID: String, userIDs: [String], completion: @escaping (Result<Bool, Error>) -> Void){
    
    }
  
}
