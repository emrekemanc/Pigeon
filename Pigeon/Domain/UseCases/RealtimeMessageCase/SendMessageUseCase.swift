//
//  SendRealtimeMessageUseCase.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 20.05.2025.
//

final class SendMessageUseCase{
    let repository: RealtimeMessageRepository
    init(repository: RealtimeMessageRepository) {
        self.repository = repository
    }
    func execute(_ message: MessageCredentials, completion: @escaping (Result<Bool, any Error>) -> Void){
        repository.sendMessage(message, completion: completion)
    }
}
