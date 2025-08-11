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
            completion(.failure(FirestoreError.invalidArgument))
            return
        }
        do {
            try db.collection(messagesCollection).document(messageID).setData(from: message) { error in
                if let error = error {
                    completion(.failure(FirestoreError(from: error)))
                } else {
                    completion(.success(message))
                }
            }
        } catch {
            completion(.failure(FirestoreError(from: error)))
        }
    }

    func fetchAllMessages(for chat: ChatCredentials, completion: @escaping (Result<[MessageCredentials], Error>) -> Void) {
        guard let chatID = chat.id else {
            completion(.failure(FirestoreError.invalidArgument))
            return
        }

        db.collection(messagesCollection)
            .whereField("chat_id", isEqualTo: chatID)
            .order(by: "created_at", descending: true)
            .getDocuments { snapshot, error in
                if let error = error {
                    completion(.failure(FirestoreError(from: error)))
                    return
                }

                let messages = snapshot?.documents.compactMap {
                    try? $0.data(as: MessageCredentials.self)
                } ?? []

                completion(.success(messages))
            }
    }
    func fetchMessage(message_id: String, completion: @escaping (Result<MessageCredentials,Error>) -> Void){
        db.collection(messagesCollection).document(message_id).getDocument { snapshot, error in
            if let error = error{
                completion(.failure(FirestoreError(from: error)))
                return
            }
            do{
                guard let snapshot = snapshot else{ completion(.failure(FirestoreError.invalidArgument)); return}
                let message = try snapshot.data(as: MessageCredentials.self)
                completion(.success(message))
            }catch{
                completion(.failure(FirestoreError(from: error)))
            }
        }
    }
    
    func deleteMessage(withID id: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        db.collection(messagesCollection).document(id).delete { error in
            if let error = error {
                completion(.failure(FirestoreError(from: error)))
            } else {
                completion(.success(true))
            }
        }
    }

    func deleteAllMessages(for chat: ChatCredentials, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let chatID = chat.id else {
            completion(.failure(FirestoreError.invalidArgument))
            return
        }

        db.collection(messagesCollection)
            .whereField("chat_id", isEqualTo: chatID)
            .getDocuments { snapshot, error in
                if let error = error {
                    completion(.failure(FirestoreError(from: error)))
                    return
                }

                let batch = self.db.batch()
                snapshot?.documents.forEach { batch.deleteDocument($0.reference) }

                batch.commit { error in
                    if let error = error {
                        completion(.failure(FirestoreError(from: error)))
                    } else {
                        completion(.success(true))
                    }
                }
            }
    }

    func updateMessage(_ message: MessageCredentials, completion: @escaping (Result<MessageCredentials, Error>) -> Void) {
        guard let id = message.id else {
            completion(.failure(FirestoreError.invalidArgument))
            return
        }

        do {
            try db.collection(messagesCollection).document(id).setData(from: message) { error in
                if let error = error {
                    completion(.failure(FirestoreError(from: error)))
                } else {
                    completion(.success(message))
                }
            }
        } catch {
            completion(.failure(FirestoreError(from: error)))
        }
    }
}
