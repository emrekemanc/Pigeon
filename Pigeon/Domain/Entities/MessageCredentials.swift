//
//  Message.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 19.05.2025.
//

import Foundation

struct MessageCredentials: Codable{
    var id: String?
    let text: String
    let sender_id: String
    let receiver_id: String
    let created_at: Date
    var chat_id: String?
}
