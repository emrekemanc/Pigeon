//
//  SearchUserUseCase.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 16.05.2025.
//

final class SearchUserUseCase{
    private let repository: UserRepository
    init(repository: UserRepository) {
        self.repository = repository
    }
    func execute(uid: String, completion: @escaping(Result<[UserCredentials],Error>) -> Void){
        repository.userSearch(uid: uid, completion: completion)
    }
}
