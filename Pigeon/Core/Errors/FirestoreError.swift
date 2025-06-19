
//
//  Firestore.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 17.06.2025.
//
import FirebaseFirestore

enum FirestoreError: Error {
    case aborted
    case alreadyExists
    case cancelled
    case dataLoss
    case deadlineExceeded
    case failedPrecondition
    case Internal
    case invalidArgument
    case notFound
    case outOfRange
    case permissionDenied
    case resourceExhausted
    case unauthenticated
    case unavailable
    case unimplemented
    case unknown
    case none
    case some
    
    init(from error: Error) {
        let errorCode = FirestoreErrorCode.Code(rawValue: (error as NSError).code)
        switch errorCode {
        case .aborted:
            self = .aborted
        case .alreadyExists:
            self = .alreadyExists
        case .cancelled:
            self = .cancelled
        case .dataLoss:
            self = .dataLoss
        case .deadlineExceeded:
            self = .deadlineExceeded
        case .failedPrecondition:
            self = .failedPrecondition
        case .internal:
            self = .Internal
        case .invalidArgument:
            self = .invalidArgument
        case .notFound:
            self = .notFound
        case .outOfRange:
            self = .outOfRange
        case .permissionDenied:
            self = .permissionDenied
        case .resourceExhausted:
            self = .resourceExhausted
        case .unauthenticated:
            self = .unauthenticated
        case .unavailable:
            self = .unavailable
        case .unimplemented:
            self = .unimplemented
        case .unknown:
            self = .unknown
        case .none:
            self = .none
        case .some(.OK):
            self = .some
        case .some(_):
            self = .some
        }
    }
    
    var localizedDescription: String {
        switch self {
        case .aborted:
            return "The operation was aborted, typically due to a concurrency issue."
        case .alreadyExists:
            return "The document or resource already exists."
        case .cancelled:
            return "The operation was cancelled before completion."
        case .dataLoss:
            return "Unrecoverable data loss or corruption occurred."
        case .deadlineExceeded:
            return "The operation took too long to complete."
        case .failedPrecondition:
            return "The operation was rejected due to a failed precondition."
        case .Internal:
            return "An internal error occurred within Firestore."
        case .invalidArgument:
            return "The request contained invalid arguments."
        case .notFound:
            return "The requested document or resource was not found."
        case .outOfRange:
            return "The operation was attempted past the valid range."
        case .permissionDenied:
            return "The client does not have permission to perform this operation."
        case .resourceExhausted:
            return "The quota or resource limit has been exhausted."
        case .unauthenticated:
            return "The request does not have valid authentication credentials."
        case .unavailable:
            return "The service is currently unavailable. Try again later."
        case .unimplemented:
            return "The operation is not implemented or supported."
        case .unknown:
            return "An unknown error occurred."
        case .none:
            return "No error occurred."
        case .some:
            return "An unspecified error occurred."
        }
    }
}
