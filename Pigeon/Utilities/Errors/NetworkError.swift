//
//  NetworkError.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 3.05.2025.
//

enum NetworkError: Error{
    case noInternet
    case timeout
    case invalidResponse
    var localizedDescription: String{
        switch self{
        case .noInternet: return "There is no internet connection."
        case .timeout: return "The request timed out."
        case .invalidResponse: return "Invalid response received from the server."
        }
    }
}
