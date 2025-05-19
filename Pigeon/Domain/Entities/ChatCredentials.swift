//
//  ChatCredentials.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 19.05.2025.
//

import Foundation

struct ChatCredentials{
    let id: String
    let user1_id: String
    let user2_id: String
    let created_at: Date
    let messages: [MessageCredentials]
}
