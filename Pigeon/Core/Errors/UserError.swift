//
//  UserError.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 16.05.2025.
//

enum UserError: Error {
    case userNotFound
    case invalidUserId
    case decodingError
    case firestoreError(Error)
    case unknownError
    case fullnameEmpity
    
    var localizedDescription: String {
        switch self {
        case .userNotFound:
            return "User not found."
        case .invalidUserId:
            return "Invalid user ID."
        case .decodingError:
            return "Failed to decode user data."
        case .firestoreError(let error):
            return error.localizedDescription
        case .fullnameEmpity:
            return "Your name and surname cannot be blank. Please enter your name and surname."
        case .unknownError:
            return "An unknown error occurred."
        }
    }
}
