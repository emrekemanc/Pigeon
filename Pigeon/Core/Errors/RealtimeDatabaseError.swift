//
//  RealtimeDatabaseError.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 18.06.2025.
//

enum RealtimeDatabaseError: Error {
    case invalidMessageID
    case snapshotParsingFailed
    case firebaseError(Error)
    
    var localizedDescription: String {
        switch self {
        case .invalidMessageID:
            return "The message ID is missing or invalid."
        case .snapshotParsingFailed:
            return "Failed to parse the message from the snapshot."
        case .firebaseError(let error):
            return error.localizedDescription
        }
    }
}
