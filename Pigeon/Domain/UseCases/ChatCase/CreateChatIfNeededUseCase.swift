//
//  CreateChatIfNeeded.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 19.05.2025.
//

final class CreateChatIfNeededUseCase{
    private let repository: ChatRepository
    init(repository: ChatRepository) {
        self.repository = repository
    }
    func execute(user1ID: String, user2ID: String, completion: @escaping (Result<ChatCredentials, any Error>)-> Void){
        repository.createChatIfNeeded(user1ID: user1ID, user2ID: user2ID, completion: completion)
    }
}
