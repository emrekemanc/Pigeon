//
//  FirebaseError.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 3.05.2025.
//

enum FirebaseError: Error{
    case unknown
    case configuration
    case tooManyRequests
    var localizedDescription: String{
        switch self{
        case .unknown: return "An unknown Firebase error occurred."
        case .configuration: return "Firebase configuration is incorrect."
        case .tooManyRequests: return "Too many requests have been sent. Please wait."
        }
        
    }
}
