//
//  AuthRepositoryImpl.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 12.05.2025.
//
final class AuthRepositoryImpl: AuthRepository{
    private let authService: AuthService = AuthService()
    func delete(completion: @escaping (Result<Bool, any Error>) -> Void) {
        authService.delete(completion: completion)
    }
    
    func login(authCredentials: AuthCredentials, completion: @escaping (Result<Bool, any Error>) -> Void) {
        authService.login(authCredentials: authCredentials, completion: completion)
    }
    
    func register(authCredentials: AuthCredentials, completion: @escaping (Result<String, any Error>) -> Void) {
        authService.register(authCredentials: authCredentials, completion: completion)
    }
    
    func signOut(completion: @escaping (Result<Bool, any Error>) -> Void) {
        authService.signOut(completion: completion)
    }
}
