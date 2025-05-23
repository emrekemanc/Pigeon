//
//  LoginUserUseCases.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 12.05.2025.
//

final class LoginUserUseCases{
    private let repository: AuthRepository
    
    init(repository: AuthRepository) {
        self.repository = repository
    }
    func execute(authCredentials: AuthCredentials, completion: @escaping (Result<Bool, any Error>) -> Void){
        repository.login(authCredentials: authCredentials, completion: completion)
    }
}
