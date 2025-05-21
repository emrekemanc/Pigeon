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

    func sendRealtimeMessage(_ message: MessageCredentials, completion: @escaping (Result<Bool, Error>) -> Void) {
        let chatID = message.chat_id
        guard let messageID = message.id else{return}

        let messageData: [String: Any] = [
            "id": messageID,
            "text": message.text,
            "sender_id": message.sender_id,
            "receiver_id": message.receiver_id,
            "created_at": message.created_at.timeIntervalSince1970,
            "chat_id": chatID
        ]

        databaseRef
            .child(chats)
            .child(chatID)
            .child(messages)
            .child(messageID)
            .setValue(messageData) { error, _ in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(true))
                }
            }
    }

    func observeMessages(chatID: String, onNewMessage: @escaping (Result<MessageCredentials, Error>) -> Void) {
        databaseRef
            .child("chats")
            .child(chatID)
            .child("messages")
            .observe(.childAdded, with: { snapshot in
                guard
                    let value = snapshot.value as? [String: Any],
                    let id = value["id"] as? String,
                    let text = value["text"] as? String,
                    let senderID = value["sender_id"] as? String,
                    let receiverID = value["receiver_id"] as? String,
                    let chatID = value["chat_id"] as? String,
                    let timestamp = value["created_at"] as? TimeInterval
                else {
                    onNewMessage(.failure(NSError(domain: "ParseError", code: 500)))
                    return
                }

                let message = MessageCredentials(
                    id: id,
                    chat_id: chatID,
                    sender_id: senderID,
                    receiver_id: receiverID,
                    text: text,
                    created_at: Date(timeIntervalSince1970: timestamp),
                    is_read: false
                )

                onNewMessage(.success(message))
            })
    }

    func removeObservers(forChatID chatID: String) {
        databaseRef
            .child(chats)
            .child(chatID)
            .child(messages)
            .removeAllObservers()
    }
}
