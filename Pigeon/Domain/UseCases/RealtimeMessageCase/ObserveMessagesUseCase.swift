//
//  ObserveMessagesUseCase.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 20.05.2025.
//

final class ObserveMessagesUseCase{
    let repository: RealtimeMessageRepository
    init(repository: RealtimeMessageRepository) {
        self.repository = repository
    }
    func execute(chatID: String, onNewMessage: @escaping (Result<String, any Error>) -> Void) {
        repository.observeMessages(chatID: chatID, onNewMessage: onNewMessage)
    }
}
