//
//  FetchChatUseCase.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 19.05.2025.
//

final class FetchChatUseCase{
    
    private let repository: ChatRepository
    init(repository: ChatRepository) {
        self.repository = repository
    }
    func execute(by id: String, completion: @escaping (Result<ChatCredentials, any Error>) -> Void){
        repository.fetchChat(by: id, completion: completion)
    }
}
