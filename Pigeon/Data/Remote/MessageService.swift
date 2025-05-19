//
//  MessageService.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 19.05.2025.
//

import Foundation
import FirebaseDatabase

final class MessageService {

    private let databaseRef = Database.database().reference()
    private let id: String = "id"
    private let text: String = "text"
    private let sender_id: String = "sender_id"
    private let receiver_id: String = "receiver_id"
    private let created_at: String = "created_at"
    private let chat_id: String = "chat_id"
    private let chats: String = "chats"
    private let messages: String = "messages"

    func sendMessage(_ message: MessageCredentials, completion: @escaping (Result<Bool,Error>) -> Void) {
        let messageData: [String: Any] = [
            id: message.id,
            text: message.text,
            sender_id: message.sender_id,
            receiver_id: message.receiver_id,
            created_at: message.created_at.timeIntervalSince1970,
            chat_id: message.chat_id
        ]

        databaseRef
            .child(chats)
            .child(message.chat_id!)
            .child(messages)
            .child(message.id!)
            .setValue(messageData) { error, _ in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(true))
                }
            }
    }


    func observeMessages(chatID: String, completion: @escaping (Result<MessageCredentials,Error>) -> Void) {
        databaseRef
            .child(chats)
            .child(chatID)
            .child(messages)
            .observe(.childAdded) { snapshot, error  in
                guard
                    let value = snapshot.value as? [String: Any],
                    let id = value[self.id] as? String,
                    let text = value[self.text] as? String,
                    let senderID = value[self.sender_id] as? String,
                    let receiverID = value[self.receiver_id] as? String,
                    let timestamp = value[self.created_at] as? TimeInterval,
                    let chatID = value[self.chat_id] as? String
                else {
                    completion(.failure(error as! Error))
                    return
                }

                let message = MessageCredentials(
                    id: id,
                    text: text,
                    sender_id: senderID,
                    receiver_id: receiverID,
                    created_at: Date(timeIntervalSince1970: timestamp),
                    chat_id: chatID
                )

                completion(.success(message))
            }
    }

    func removeObservers(chatID: String) {
        databaseRef
            .child(chats)
            .child(chatID)
            .child(messages)
            .removeAllObservers()
    }
}
