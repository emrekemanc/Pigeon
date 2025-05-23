//
//  UserCredentials.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 16.05.2025.
//

import Foundation
import FirebaseFirestore

struct UserCredentials: Codable, Identifiable {
    @DocumentID var id: String?
    var fullname: String
    var email: String
    var created_at: Date
    var updated_at: Date
    var fcm_token: String?
    var chat_ids: [String]
}
