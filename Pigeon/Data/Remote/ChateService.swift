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

    func createChatIfNeeded(user1ID: String, user2ID: String, completion: @escaping (Result<ChatCredentials, Error>) -> Void) {
        let chatQuery = db.collection(chatsCollection)
            .whereField("user1_id", isEqualTo: user1ID)
            .whereField("user2_id", isEqualTo: user2ID)

        chatQuery.getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let existingDoc = snapshot?.documents.first,
               let chat = try? existingDoc.data(as: ChatCredentials.self) {
                completion(.success(chat))
                return
            }

            let chatID = UUID().uuidString
            let createdAt = Date()
            let newChat = ChatCredentials(
                id: chatID,
                user1_id: user1ID,
                user2_id: user2ID,
                created_at: createdAt,
                messages_id: []
            )

            do {
                try self.db.collection(self.chatsCollection).document(chatID).setData(from: newChat)

                self.appendChannelIDToUsers(chatID: chatID, user1ID: user1ID, user2ID: user2ID) { result in
                    switch result {
                    case .success:
                        completion(.success(newChat))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }

            } catch {
                completion(.failure(error))
            }
        }
    }

    func fetchChat(by id: String, completion: @escaping (Result<ChatCredentials, Error>) -> Void) {
        db.collection(chatsCollection).document(id).getDocument { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let snapshot = snapshot,
                  let chat = try? snapshot.data(as: ChatCredentials.self) else {
                completion(.failure(NSError(domain: "ChatNotFound", code: 404)))
                return
            }

            completion(.success(chat))
        }
    }

    private func appendChannelIDToUsers(chatID: String, user1ID: String, user2ID: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        let group = DispatchGroup()
        var lastError: Error?

        for userID in [user1ID, user2ID] {
            group.enter()
            let userRef = db.collection(usersCollection).document(userID)

            userRef.updateData([
                "channel_ids": FieldValue.arrayUnion([chatID])
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
