//
//  AuthCredentiels.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 12.05.2025.
//

struct AuthCredentials {
    let email: String
    let password: String

    var validationError: AuthError? {
        if !email.isValidEmail() {
            return .invalidEmail
        }
        if !password.isValidPassword() {
            return .weakPassword
        }
        return nil
    }
}
