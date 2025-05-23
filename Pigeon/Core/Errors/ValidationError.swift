//
//  ValidationError.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 17.05.2025.
//

enum ValidationError: Error {
    case emptyEmail
    case invalidEmailFormat
    case emptyPassword
    case weakPassword
    case emptyFullName
    case invalidPhoneNumber
    case mismatchPasswords
    case unknown

    var localizedDescription: String {
        switch self {
        case .emptyEmail:
            return "Email address cannot be empty."
        case .invalidEmailFormat:
            return "Please enter a valid email address."
        case .emptyPassword:
            return "Password cannot be empty."
        case .weakPassword:
            return "Please enter a valid password"
        case .emptyFullName:
            return "Full name cannot be empty."
        case .invalidPhoneNumber:
            return "Please enter a valid phone number."
        case .mismatchPasswords:
            return "Passwords do not match."
        case .unknown:
            return "An unknown validation error occurred."
        }
    }
}
