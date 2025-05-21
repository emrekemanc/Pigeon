//
//  ChatCredentials.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 19.05.2025.
//

import Foundation
import FirebaseFirestore
struct ChatCredentials: Codable, Identifiable {
   @DocumentID var id: String?
    var user1_id: String
    var user2_id: String
    var created_at: Date
    var messages_ids: [String]
}
