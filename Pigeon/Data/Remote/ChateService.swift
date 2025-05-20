//
//  ChateService.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 19.05.2025.
//

import Foundation
import FirebaseFirestore

final class ChatService {
    
    private let db = Firestore.firestore()
    private let chatsCollection = "chats"
    private let usersCollection = "users"
    
    
    func fetchUserChatIDs(userID: String, completion: @escaping (Result<[String], Error>) -> Void) {
        let userRef = db.collection(usersCollection).document(userID)
        
        userRef.getDocument { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = snapshot?.data(),
                  let chatIDs = data["chat_ids"] as? [String] else {
                completion(.success([]))
                return
            }
            completion(.success(chatIDs))
        }
    }


    func fetchChat(by chatID: String, completion: @escaping (Result<ChatCredentials, Error>) -> Void) {
        let chatRef = db.collection(chatsCollection).document(chatID)
        
        chatRef.getDocument { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let chat = try? snapshot?.data(as: ChatCredentials.self) else {
                completion(.failure(NSError(domain: "ChatNotFound", code: 404)))
                return
            }
            completion(.success(chat))
        }
    }

    func checkIfChatExists(between chat: ChatCredentials, completion: @escaping (Result<ChatCredentials?, Error>) -> Void) {
        db.collection(chatsCollection)
            .whereField("user1_id", in: [chat.user1_id, chat.user2_id])
            .getDocuments { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                let chats = snapshot?.documents.compactMap {
                    try? $0.data(as: ChatCredentials.self)
                } ?? []

                let existingChat = chats.first(where: {
                    ($0.user1_id == chat.user1_id && $0.user2_id == chat.user2_id) ||
                    ($0.user1_id == chat.user2_id && $0.user2_id == chat.user1_id)
                })

                completion(.success(existingChat))
            }
    }

   
    func createChat(_ chat: ChatCredentials, completion: @escaping (Result<ChatCredentials, Error>) -> Void) {
        guard let chatID = chat.id else {
            completion(.failure(NSError(domain: "InvalidChatID", code: 400)))
            return
        }

        do {
            try db.collection(chatsCollection).document(chatID).setData(from: chat) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    self.addChatIDToUsers(chatID: chatID, userIDs: [chat.user1_id, chat.user2_id]) { result in
                        switch result {
                        case .success:
                            completion(.success(chat))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                }
            }
        } catch {
            completion(.failure(error))
        }
    }

    func appendMessageToChat(chat: ChatCredentials, messageID: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let chatID = chat.id else {
            completion(.failure(NSError(domain: "ChatService", code: 400, userInfo: [NSLocalizedDescriptionKey: "Geçersiz chat ID"])))
            return
        }

        let chatRef = db.collection(chatsCollection).document(chatID)
        chatRef.updateData([
            "messages_id": FieldValue.arrayUnion([messageID])
        ]) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }

   
    private func addChatIDToUsers(chatID: String, userIDs: [String], completion: @escaping (Result<Bool, Error>) -> Void) {
        let group = DispatchGroup()
        var lastError: Error?

        for userID in userIDs {
            group.enter()
            let userRef = db.collection(usersCollection).document(userID)
            userRef.updateData([
                "chat_ids": FieldValue.arrayUnion([chatID])
            ]) { error in
                if let error = error {
                    lastError = error
                }
                group.leave()
            }
        }

        group.notify(queue: .main) {
            if let error = lastError {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
}
