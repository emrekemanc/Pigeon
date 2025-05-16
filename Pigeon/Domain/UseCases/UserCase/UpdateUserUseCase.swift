//
//  UpdateUserUseCase.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 16.05.2025.
//

final class UpdateUserUseCase{
    private let repository: UserRepository
    init(repository: UserRepository) {
        self.repository = repository
    }
    func execute(userCredentials: UserCredentials, completion: @escaping(Result<Bool,Error>) -> Void){
        repository.userUpdate(userCredentials: userCredentials, completion: completion)
    }
}
