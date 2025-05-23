//
//  UpdateMessageUseCase.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 21.05.2025.
//

final class UpdateMessageUseCase{
    private let repository: MessageRepository
    init(repository: MessageRepository) {
        self.repository = repository
    }
    func execute(_ message: MessageCredentials, completion: @escaping (Result<MessageCredentials, any Error>) -> Void) {
        repository.updateMessage(message, completion: completion)
    }
}
