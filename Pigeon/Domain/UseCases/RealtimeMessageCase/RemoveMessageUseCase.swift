//
//  RemoveObserversUseCase.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 20.05.2025.
//

final class RemoveMessageUseCase{
    let repository: RealtimeMessageRepository
    init(repository: RealtimeMessageRepository) {
        self.repository = repository
    }
    func execute(chatID: String, messageID: String, completion: @escaping (Result<Bool, any Error>) -> Void) {
        repository.removeMessage(chatID: chatID, messageID: messageID, completion: completion)
    }
}
