//
//  RemoveObserversUseCase.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 20.05.2025.
//

final class RemoveObserversUseCase{
    let repository: RealtimeMessageRepository
    init(repository: RealtimeMessageRepository) {
        self.repository = repository
    }
    func execute(forChatID chatID: String){
        repository.removeObservers(forChatID: chatID)
    }
}
