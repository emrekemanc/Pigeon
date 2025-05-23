//
//  ChatRepository.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 19.05.2025.
//

protocol ChatRepository {
    func fetchUserChatIDs(userID: String, completion: @escaping (Result<[String], Error>) -> Void) 
    func createChat(_ chat: ChatCredentials, completion: @escaping (Result<ChatCredentials, Error>) -> Void)
    func fetchChat(by chatID: String, completion: @escaping (Result<ChatCredentials, Error>) -> Void)
    func checkIfChatExists(between chat: ChatCredentials, completion: @escaping (Result<ChatCredentials?, Error>) -> Void)
    func appendMessageToChat(chat: ChatCredentials, messageID: String, completion: @escaping (Result<Bool, Error>) -> Void)
    func addChatIDToUsers(chatID: String, userIDs: [String], completion: @escaping (Result<Bool, Error>) -> Void)
}
