//
//  AppendMessageToChatUseCase.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 20.05.2025.
//

final class AppendMessageToChatUseCase{
    let repository: ChatRepository
    init(repository: ChatRepository) {
        self.repository = repository
    }
    func execute(chat: ChatCredentials, messageID: String, completion: @escaping (Result<Bool, Error>) -> Void){
        repository.appendMessageToChat(chat: chat, messageID: messageID, completion: completion)
    }
}
