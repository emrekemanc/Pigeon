//
//  UserUseCase.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 16.05.2025.
//

final class CreateUserUseCase{
    private let repository: UserRepository
    init(repository: UserRepository) {
        self.repository = repository
    }
    
    func execute(userCredentials: UserCredentials, completion: @escaping(Result<Bool,Error>) -> Void){
        repository.userCreate(userCredentials: userCredentials, completion: completion)
    }
}
