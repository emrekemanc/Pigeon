//
//  FetchUserUseCase.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 16.05.2025.
//

final class FetchUserUseCase{
    private let repository: UserRepository
    init(repository: UserRepository) {
        self.repository = repository
    }
    func execute(uid: String, completion: @escaping (Result<UserCredentials, any Error>) -> Void){
        repository.userFetch(uid: uid, completion: completion)
    }
}
