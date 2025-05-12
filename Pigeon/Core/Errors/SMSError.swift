//
//  SMSError.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 3.05.2025.
//

enum SMSError: Error{
    case invalidCode
    case codeExpired
    case failedToSend
    var localizedDescription: String{
        switch self{
        case .invalidCode: return "The code entered is invalid."
        case .codeExpired: return "The code has expired."
        case .failedToSend: return "SMS sending failed. Please try again."
        }
    }
}
