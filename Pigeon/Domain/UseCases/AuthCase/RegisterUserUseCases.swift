//
//  RegisterUserUseCases.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 12.05.2025.
//

final class RegisterUserUseCases{
    private let repository: AuthRepository
    
    init(repository: AuthRepository) {
        self.repository = repository
    }
    func execute(authCredentials: AuthCredentials, completion: @escaping (Result<String, any Error>) -> Void){
        repository.register(authCredentials: authCredentials, completion: completion)
    }
}
