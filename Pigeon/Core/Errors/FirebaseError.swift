//
//  FirebaseError.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 3.05.2025.
//
enum FirebaseError: Error {
    case unknown
    case configuration
    case tooManyRequests
    case user(UserError)

    var code: String {
        switch self {
        case .unknown: return "UNKNOWN"
        case .configuration: return "CONFIGURATION"
        case .tooManyRequests: return "TOO_MANY_REQUESTS"
        case .user(let userError): return userError.code
        }
    }

    var localizedDescription: String {
        switch self {
        case .unknown:
            return "An unknown Firebase error occurred."
        case .configuration:
            return "Firebase configuration is incorrect."
        case .tooManyRequests:
            return "Too many requests have been sent. Please wait."
        case .user(let userError):
            return userError.localizedDescription
        }
    }
}

