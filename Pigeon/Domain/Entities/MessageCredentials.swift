//
//  Message.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 19.05.2025.
//

import Foundation
import FirebaseFirestore

struct MessageCredentials: Codable, Identifiable {
    @DocumentID var id: String?
    var chat_id: String
    var sender_id: String
    var receiver_id: String
    var text: String
    var created_at: Date
    var is_read: Bool
}
