//
//  AuthError.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 3.05.2025.
//
import FirebaseAuth

enum AuthError: Error {
    case invalidEmail
    case wrongPassword
    case userNotFound
    case emailAlreadyInUse
    case weakPassword
    case userDisabled
    case missingEmail
    case unknown

    init(from error: Error) {
        guard let errorCode = AuthErrorCode(rawValue: (error as NSError).code) else {
            self = .unknown
            return
        }

        switch errorCode {
        case .invalidEmail:
            self = .invalidEmail
        case .wrongPassword:
            self = .wrongPassword
        case .userNotFound:
            self = .userNotFound
        case .emailAlreadyInUse:
            self = .emailAlreadyInUse
        case .weakPassword:
            self = .weakPassword
        case .userDisabled:
            self = .userDisabled
        case .missingEmail:
            self = .missingEmail
        default:
            self = .unknown
        }
    }

    var localizedDescription: String {
        switch self {
        case .invalidEmail:
            return "Please enter a valid email address."
        case .wrongPassword:
            return "The password you entered is incorrect."
        case .userNotFound:
            return "No account found with this email address."
        case .emailAlreadyInUse:
            return "This email address is already in use."
        case .weakPassword:
            return "Your password is too weak. Please choose a stronger one."
        case .userDisabled:
            return "This user account has been disabled."
        case .missingEmail:
            return "Email address is missing."
        case .unknown:
            return "An unknown error occurred. Please try again."
        }
    }
}
