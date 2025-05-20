//
//  CheckIfChatExistsUseCase.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 20.05.2025.
//

final class CheckIfChatExistsUseCase{
    let repository: ChatRepository
    init(repository: ChatRepository) {
        self.repository = repository
    }
    func execute(between chat: ChatCredentials, completion: @escaping (Result<ChatCredentials?, Error>) -> Void){
        execute(between: chat, completion: completion)
    }
}
