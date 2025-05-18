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
    func execute(mail: String, completion: @escaping(Result<[UserCredentials],Error>) -> Void){
        repository.userSearch(mail: mail, completion: completion)
    }
}
