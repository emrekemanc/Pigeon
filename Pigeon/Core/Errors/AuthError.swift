//
//  AuthError.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 3.05.2025.
//

import FirebaseAuth
import FirebaseAuth

enum AuthError: Error, LocalizedError {
    case invalidEmail
    case wrongPassword
    case userNotFound
    case userDisabled
    case emailAlreadyInUse
    case weakPassword
    case operationNotAllowed
    case tooManyRequests
    case networkError
    case internalError
    case requiresRecentLogin
    case credentialAlreadyInUse
    case invalidCredential
    case unknown

    init(from error: Error) {
        let codeValue = (error as NSError).code
        print(codeValue)
        if let errorCode = AuthErrorCode(rawValue: codeValue)?.code {
            switch errorCode {
            case .invalidEmail:
                self = .invalidEmail
            case .wrongPassword:
                self = .wrongPassword
            case .userNotFound:
                self = .userNotFound
            case .userDisabled:
                self = .userDisabled
            case .emailAlreadyInUse:
                self = .emailAlreadyInUse
            case .weakPassword:
                self = .weakPassword
            case .operationNotAllowed:
                self = .operationNotAllowed
            case .tooManyRequests:
                self = .tooManyRequests
            case .networkError:
                self = .networkError
            case .internalError:
                self = .internalError
            case .requiresRecentLogin:
                self = .requiresRecentLogin
            case .credentialAlreadyInUse:
                self = .credentialAlreadyInUse
            case .invalidCredential:
                self = .invalidCredential
            default:
                self = .unknown
            }
        } else {
            self = .unknown
        }
    }

    var errorDescription: String? {
        switch self {
        case .invalidEmail:
            return "The email address is badly formatted."
        case .wrongPassword:
            return "The password is incorrect."
        case .userNotFound:
            return "No user found with this email."
        case .userDisabled:
            return "This user account has been disabled."
        case .emailAlreadyInUse:
            return "This email is already associated with another account."
        case .weakPassword:
            return "The password is too weak. Please use a stronger password."
        case .operationNotAllowed:
            return "This authentication operation is not allowed."
        case .tooManyRequests:
            return "Too many requests. Try again later."
        case .networkError:
            return "A network error occurred. Check your internet connection."
        case .internalError:
            return "An internal error occurred. Please try again."
        case .requiresRecentLogin:
            return "Please log in again to perform this operation."
        case .credentialAlreadyInUse:
            return "This credential is already associated with another account."
        case .invalidCredential:
            return "The credential is invalid or has expired."
        case .unknown:
            return "An unknown authentication error occurred."
        }
    }
}
