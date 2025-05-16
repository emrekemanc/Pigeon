//
//  DeleteUseCase.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 16.05.2025.
//


final class DeleteUseCase{
    let repository: AuthRepository
    init(repository: AuthRepository) {
        self.repository = repository
    }
    func execute( completion: @escaping (Result<Bool, any Error>) -> Void){
        repository.delete(completion: completion)
    }
}
