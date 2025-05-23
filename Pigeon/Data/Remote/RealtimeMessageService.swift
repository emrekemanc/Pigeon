//
//  Untitled.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 20.05.2025.
//

import Foundation
import FirebaseDatabase


final class RealtimeMessageService {

    private let databaseRef = Database.database(url: "https://pigeon-d7730-default-rtdb.europe-west1.firebasedatabase.app").reference()
    private let chats = "chats"
    private let messages = "messages"
    
    func sendMessage(_ message: MessageCredentials, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let messageID = message.id else {
            completion(.failure(NSError(domain: "RealtimeMessageService", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid message ID"])))
            return
        }
        let chatID = message.chat_id
        let messageData: [String: Any] = [
            "id": messageID,
            "created_at": message.created_at.timeIntervalSince1970
        ]
        databaseRef.child(chats).child(chatID).child(messages).child(messageID).setValue(messageData) { error, _ in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    func observeMessages(chatID: String, onNewMessage: @escaping (Result<String, Error>) -> Void) {
        databaseRef.child(chats).child(chatID).child(messages)
            .observe(.childAdded) { snapshot in
                guard
                    let value = snapshot.value as? [String: Any],
                    let id = value["id"] as? String
                else {
                    onNewMessage(.failure(NSError(domain: "ParseError", code: 500)))
                    return
                }
                onNewMessage(.success(id))
            }
    }
    
    func removeMessage(chatID: String, messageID: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        databaseRef.child(chats).child(chatID).child(messages).child(messageID).removeValue { error, _ in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    func cleanOldMessagesForSender(chatID: String, completion: ((Result<Bool, Error>) -> Void)? = nil) {
        let messagesRef = databaseRef.child(chats).child(chatID).child(messages)
        messagesRef.observeSingleEvent(of: .value) { snapshot in
            guard let children = snapshot.children.allObjects as? [DataSnapshot] else {
                completion?(.success(true))
                return
            }
            
            let now = Date().timeIntervalSince1970
            let dispatchGroup = DispatchGroup()
            var errorOccurred: Error?

            for child in children {
                if
                    let value = child.value as? [String: Any],
                    let createdAt = value["created_at"] as? TimeInterval,
                    now - createdAt > 20
                {
                    dispatchGroup.enter()
                    child.ref.removeValue { error, _ in
                        if let error = error {
                            errorOccurred = error
                        }
                        dispatchGroup.leave()
                    }
                }
            }

            dispatchGroup.notify(queue: .main) {
                if let error = errorOccurred {
                    completion?(.failure(error))
                } else {
                    completion?(.success(true))
                }
            }
        }
    }
}
