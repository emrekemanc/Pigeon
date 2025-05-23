//
//  DeleteMessageUseCase.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 21.05.2025.
//

final class DeleteMessageUseCase{
    private let repository: MessageRepository
    init(repository: MessageRepository) {
        self.repository = repository
    }
    func execute(withID id: String, completion: @escaping (Result<Bool, any Error>) -> Void){
        repository.deleteMessage(withID: id, completion: completion)
    }
}
