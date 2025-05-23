//
//  CleanOldMessagesForSenderUseCase.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 21.05.2025.
//

final class CleanOldMessagesForSenderUseCase{
    let repository: RealtimeMessageRepository
    init(repository: RealtimeMessageRepository) {
        self.repository = repository
    }
    func execute(chatID: String, completion: ((Result<Bool, any Error>) -> Void)?) {
        repository.cleanOldMessagesForSender(chatID: chatID, completion: completion)
    }
}
