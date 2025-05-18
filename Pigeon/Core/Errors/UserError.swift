//
//  UserError.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 16.05.2025.
//

enum UserError: Error {
    case userNotFound
    case invalidUserId
    case decodingError
    case firestoreError(Error)
    case unknownError
    case fullnameEmpty

    var code: String {
        switch self {
        case .userNotFound: return "USER_NOT_FOUND"
        case .invalidUserId: return "INVALID_USER_ID"
        case .decodingError: return "DECODING_ERROR"
        case .firestoreError: return "FIRESTORE_ERROR"
        case .unknownError: return "UNKNOWN_ERROR"
        case .fullnameEmpty: return "FULLNAME_EMPTY"
        }
    }

    var localizedDescription: String {
        switch self {
        case .userNotFound:
            return "The user does not exist in the database."
        case .invalidUserId:
            return "The provided user ID is invalid."
        case .decodingError:
            return "Failed to decode user data."
        case .firestoreError(let error):
            return error.localizedDescription
        case .unknownError:
            return "An unknown error occurred while handling the user."
        case .fullnameEmpty:
            return "Name and surname cannot be left empty."
        }
    }
}
