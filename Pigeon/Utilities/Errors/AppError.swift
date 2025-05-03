//
//  AppError.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 3.05.2025.
//

enum AppError: Error{
    case auth(AuthError)
    case firebase(FirebaseError)
    case network(NetworkError)
    case sms(SMSError)
    case unknown(String)
    
    var localizedDescription: String{
        switch self {
        case .auth(let error): return error.localizedDescription
        case .firebase(let error): return error.localizedDescription
        case .network(let error): return error.localizedDescription
        case .sms(let error): return error.localizedDescription
        case .unknown(let message): return message
               }
    }
}
