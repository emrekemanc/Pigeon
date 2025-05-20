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

    func sendMessage(_ message: MessageCredentials, completion: @escaping (Result<MessageCredentials, Error>) -> Void) {
        guard let messageID = message.id else {
            completion(.failure(NSError(domain: "MessageService", code: 400, userInfo: [NSLocalizedDescriptionKey: "Geçersiz mesaj ID"])))
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

    func fetchMessages(for chat: ChatCredentials, completion: @escaping (Result<[MessageCredentials], Error>) -> Void) {
        guard let chatID = chat.id else {
            completion(.failure(NSError(domain: "MessageService", code: 400, userInfo: [NSLocalizedDescriptionKey: "Geçersiz chat ID"])))
            return
        }

        db.collection(messagesCollection)
            .whereField("chat_id", isEqualTo: chatID)
            .order(by: "created_at", descending: false)
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
}
