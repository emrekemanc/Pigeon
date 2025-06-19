//
//  NetworkError.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 3.05.2025.
//

enum NetworkError: Error {
    case noConnection
    case timeout
    case unreachableHost
    case badResponse
    case unknown

    var localizedDescription: String {
        switch self {
        case .noConnection:
            return "No internet connection. Please check your network settings."
        case .timeout:
            return "The request timed out. Please try again later."
        case .unreachableHost:
            return "The server is unreachable."
        case .badResponse:
            return "The server returned an invalid response."
        case .unknown:
            return "An unknown network error occurred."
        }
    }
}
