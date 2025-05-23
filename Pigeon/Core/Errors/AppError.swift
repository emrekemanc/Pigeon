//
//  AppError.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 3.05.2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


enum AppError: Error {
    case auth(AuthError)
    case firebase(FirebaseError)
    case network(NetworkError)
    case sms(SMSError)
    case validation(ValidationError)
    case unknown(String)

    var localizedDescription: String {
        switch self {
        case .auth(let error): return error.localizedDescription
        case .firebase(let error): return error.localizedDescription
        case .network(let error): return error.localizedDescription
        case .sms(let error): return error.localizedDescription
        case .validation(let error): return error.localizedDescription
        case .unknown(let message): return message
        }
    }

    var code: String {
        switch self {
        case .auth(let error): return "AUTH_\(error.code)"
        case .firebase(let error): return "FIREBASE_\(error.code)"
        case .network(let error): return "NETWORK_\(error.code)"
        case .sms(let error): return "SMS_\(error.code)"
        case .unknown: return "UNKNOWN"
        case .validation(_):
            return " "
        
        }
    }

    static func handle(_ error: Error) -> AppError {
        let nsError = error as NSError

        if nsError.domain == AuthErrorDomain {
            return .auth(AuthError(from: error))
        }

        if nsError.domain == FirestoreErrorDomain {
            switch nsError.code {
            case FirestoreErrorCode.notFound.rawValue:
                return .firebase(.user(.userNotFound))
            case FirestoreErrorCode.invalidArgument.rawValue:
                return .firebase(.user(.invalidUserId))
            case FirestoreErrorCode.dataLoss.rawValue:
                return .firebase(.user(.decodingError))
            case FirestoreErrorCode.permissionDenied.rawValue:
                return .firebase(.configuration)
            case FirestoreErrorCode.resourceExhausted.rawValue:
                return .firebase(.tooManyRequests)
            default:
                return .firebase(.unknown)
            }
        }

        switch error {
        case let appError as AppError: return appError
        case let authError as AuthError: return .auth(authError)
        case let userError as UserError: return .firebase(.user(userError))
        case let firebaseError as FirebaseError: return .firebase(firebaseError)
        case let validationError as ValidationError: return .validation(validationError)
        case let networkError as NetworkError: return .network(networkError)
        case let smsError as SMSError: return .sms(smsError)
        default: return .unknown(error.localizedDescription)
        }
    }
}

