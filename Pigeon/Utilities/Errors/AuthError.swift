//
//  AuthError.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 3.05.2025.
//

enum AuthError: Error{
    case invalidCredentials
    case userNotFound
    case weakPassword
    case emailAlreadyInUse
    
    var localizedDescription: String{
        switch self{
        case .invalidCredentials: return "Invalid email or password."
        case .userNotFound: return "User not found."
        case .weakPassword: return "Weak password."
        case .emailAlreadyInUse: return "Email is already used."
        }
    }
}
