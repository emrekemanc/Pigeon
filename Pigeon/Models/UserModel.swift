//
//  UserModel.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 3.05.2025.
//
import Foundation

struct UserModel{
    let uid: String
    let name: String
    let last_name: String
    let mail: String
    let msisdn: String
    let password: String
    let age: Int
    let email_verified: Bool
    let msisdn_verified: Bool
    let created_at: Date
    let last_login_at: Date
    let deleted_at: Date?
}
