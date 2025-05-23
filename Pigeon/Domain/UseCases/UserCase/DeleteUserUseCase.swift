//
//  DeleteUserUseCase.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 16.05.2025.
//

final class DeleteUserUseCase{
    private let repository: UserRepository
    init(repository: UserRepository) {
        self.repository = repository
    }
    func execute(uid: String, completion: @escaping(Result<Bool,Error>) -> Void){
        repository.userDeleted(uid: uid, completion: completion)
    }
}
