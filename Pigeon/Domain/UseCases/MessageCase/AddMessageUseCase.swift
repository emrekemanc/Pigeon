//
//  ObserveMessagesUseCase.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 19.05.2025.
//

final class AddMessageUseCase{
    private let repository: MessageRepository
    init(repository: MessageRepository) {
        self.repository = repository
    }
    func execute(_ message: MessageCredentials, completion: @escaping (Result<MessageCredentials, any Error>) -> Void){
        repository.addMessage(message, completion: completion)
    }
}
