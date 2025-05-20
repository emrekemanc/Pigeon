//
//  CreateChatUseCase.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 20.05.2025.
//

final class CreateChatUseCase{
    let repository: ChatRepository
    init(repository: ChatRepository) {
        self.repository = repository
    }
    func execute(_ chat: ChatCredentials, completion: @escaping (Result<ChatCredentials, Error>) -> Void){
        repository.createChat(chat, completion: completion)
    }
}
