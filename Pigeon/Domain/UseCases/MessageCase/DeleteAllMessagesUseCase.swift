//
//  DeleteAllMessagesUseCase.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 21.05.2025.
//

final class DeleteAllMessagesUseCase{
    private let repository: MessageRepository
    init(repository: MessageRepository) {
        self.repository = repository
    }
    func execute(for chat: ChatCredentials, completion: @escaping (Result<Bool, any Error>) -> Void){
        repository.deleteAllMessages(for: chat, completion: completion)
    }
}
