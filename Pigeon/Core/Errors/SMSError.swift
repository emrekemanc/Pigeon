//
//  SMSError.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 3.05.2025.
//

enum SMSError: Error {
    case codeExpired
    case invalidCode
    case quotaExceeded
    case notVerified
    case unknown

    var code: String {
        switch self {
        case .codeExpired: return "CODE_EXPIRED"
        case .invalidCode: return "INVALID_CODE"
        case .quotaExceeded: return "QUOTA_EXCEEDED"
        case .notVerified: return "NOT_VERIFIED"
        case .unknown: return "UNKNOWN"
        }
    }

    var localizedDescription: String {
        switch self {
        case .codeExpired:
            return "The SMS verification code has expired. Please request a new one."
        case .invalidCode:
            return "The SMS verification code is invalid."
        case .quotaExceeded:
            return "SMS quota exceeded. Please try again later."
        case .notVerified:
            return "Phone number has not been verified."
        case .unknown:
            return "An unknown SMS verification error occurred."
        }
    }
}
