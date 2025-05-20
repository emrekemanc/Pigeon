//
//  ObserveMessagesUseCase.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 19.05.2025.
//

final class FetchMessagesUseCase{
    private let repository: MessageRepository
    init(repository: MessageRepository) {
        self.repository = repository
    }
    func execute(for chat: ChatCredentials, completion: @escaping (Result<[MessageCredentials], Error>) -> Void){
        repository.fetchMessages(for: chat, completion: completion)
    }
}
