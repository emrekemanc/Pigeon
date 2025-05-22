//
//  FetchMessageUseCase.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 21.05.2025.
//

final class FetchMessageUseCase{
    private let repository: MessageRepository
    init(repository: MessageRepository) {
        self.repository = repository
    }
    func execute(message_id: String, completion: @escaping (Result<MessageCredentials,Error>) -> Void){
        repository.fetchMessage(message_id: message_id, completion: completion)
    }
}
