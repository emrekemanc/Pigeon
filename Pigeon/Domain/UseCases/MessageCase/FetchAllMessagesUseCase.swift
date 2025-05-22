//
//  SendMessageUseCase.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 19.05.2025.
//

final class FetchAllMessagesUseCase{
    private let repository: MessageRepository
    init(repository: MessageRepository) {
        self.repository = repository
    }
    func execute(for chat: ChatCredentials, completion: @escaping (Result<[MessageCredentials], any Error>) -> Void){
        repository.fetchAllMessages(for: chat, completion: completion)
    }
}
