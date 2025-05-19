//
//  Untitled.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 19.05.2025.
//

final class RemoveObserversUseCase{
    private let repository: MessageRepository
    init(repository: MessageRepository) {
        self.repository = repository
    }
    func execute(chatID: String){
        repository.removeObservers(chatID: chatID)
    }
}
