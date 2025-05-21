//
//  FetchUserIdUseCase.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 19.05.2025.
//

final class FetchUserIdUseCase{
    private let repository: AuthRepository
    init(repository: AuthRepository) {
        self.repository = repository
    }
    func execute(completion: @escaping(Result<String,Error>) -> Void){
        repository.fetchUserId(completion: completion)
    }
}
