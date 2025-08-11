//
//  FirebaseError.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 3.05.2025.
//
import Firebase
enum FirebaseError: Error {
    case unknown
    case configuration
    case tooManyRequests
    
    init(from error: Error){
        let errorCode = FirebaseError(from: error)
        
        switch errorCode{
        case .unknown:
            self = .unknown
        case .configuration:
            self = .configuration
        case .tooManyRequests:
            self = .tooManyRequests
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
        }
    }
}

