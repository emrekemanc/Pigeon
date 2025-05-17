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
    case emailEmpty
    case weakPassword
    case passwordEmpty
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

    var code: String {
        switch self {
        case .invalidEmail: return "INVALID_EMAIL"
        case .wrongPassword: return "WRONG_PASSWORD"
        case .userNotFound: return "USER_NOT_FOUND"
        case .emailAlreadyInUse: return "EMAIL_ALREADY_IN_USE"
        case .emailEmpty: return "EMAIL_EMPTY"
        case .weakPassword: return "WEAK_PASSWORD"
        case .passwordEmpty: return "PASSWORD_EMPTY"
        case .userDisabled: return "USER_DISABLED"
        case .missingEmail: return "MISSING_EMAIL"
        case .unknown: return "UNKNOWN"
        }
    }

    var localizedDescription: String {
        switch self {
        case .invalidEmail:
            return "The email address format is invalid."
        case .wrongPassword:
            return "The password entered is incorrect."
        case .userNotFound:
            return "No user was found with this email."
        case .emailAlreadyInUse:
            return "This email is already associated with another account."
        case .emailEmpty:
            return "Email address cannot be empty."
        case .weakPassword:
            return "The password is too weak. Please choose a stronger password."
        case .passwordEmpty:
            return "Password cannot be empty."
        case .userDisabled:
            return "This user account has been disabled."
        case .missingEmail:
            return "Email address is required."
        case .unknown:
            return "An unknown authentication error occurred."
        }
    }
}
