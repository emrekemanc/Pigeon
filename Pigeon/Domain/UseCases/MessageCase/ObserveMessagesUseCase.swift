//
//  ObserveMessagesUseCase.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 19.05.2025.
//

final class ObserveMessagesUseCase{
    private let repository: MessageRepository
    init(repository: MessageRepository) {
        self.repository = repository
    }
    func execute(chatID: String, completion: @escaping (Result<MessageCredentials,Error>) -> Void){
        repository.observeMessages(chatID: chatID, completion: completion)
    }
}
