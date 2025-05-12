//
//  EmailError.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 3.05.2025.
//

enum EmailError: Error{
    case invalidCode
    case codeExpired
    case failedToSend
    var localizedDescription: String{
        switch self{
        case .invalidCode: return "The code entered is invalid."
        case .codeExpired: return "The code has expired."
        case .failedToSend: return "Email sending failed. Please try again."
        }
    }
}
