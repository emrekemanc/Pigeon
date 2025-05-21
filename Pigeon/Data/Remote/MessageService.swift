//
//  MessageService.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 19.05.2025.
//
import Foundation
import FirebaseFirestore

final class MessageService {

    private let db = Firestore.firestore()
    private let messagesCollection = "messages"

    func addMessage(_ message: MessageCredentials, completion: @escaping (Result<MessageCredentials, Error>) -> Void) {
        guard let messageID = message.id else {
            completion(.failure(NSError(domain: "MessageService", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid message ID"])))
            return
        }

        do {
            try db.collection(messagesCollection).document(messageID).setData(from: message) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(message))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }

    func fetchAllMessages(for chat: ChatCredentials, completion: @escaping (Result<[MessageCredentials], Error>) -> Void) {
        guard let chatID = chat.id else {
            completion(.failure(NSError(domain: "MessageService", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid chat ID"])))
            return
        }

        db.collection(messagesCollection)
            .whereField("chat_id", isEqualTo: chatID)
            .order(by: "created_at", descending: true)
            .getDocuments { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                let messages = snapshot?.documents.compactMap {
                    try? $0.data(as: MessageCredentials.self)
                } ?? []

                completion(.success(messages))
            }
    }
    func deleteMessage(withID id: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        db.collection(messagesCollection).document(id).delete { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }

    func deleteAllMessages(for chat: ChatCredentials, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let chatID = chat.id else {
            completion(.failure(NSError(domain: "MessageService", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid chat ID"])))
            return
        }

        db.collection(messagesCollection)
            .whereField("chat_id", isEqualTo: chatID)
            .getDocuments { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                let batch = self.db.batch()
                snapshot?.documents.forEach { batch.deleteDocument($0.reference) }

                batch.commit { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(true))
                    }
                }
            }
    }

    func updateMessage(_ message: MessageCredentials, completion: @escaping (Result<MessageCredentials, Error>) -> Void) {
        guard let id = message.id else {
            completion(.failure(NSError(domain: "MessageService", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid message ID"])))
            return
        }

        do {
            try db.collection(messagesCollection).document(id).setData(from: message) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(message))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
}
