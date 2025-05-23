//
//  CreateChatIfNeeded.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 19.05.2025.
//

final class FetchUserChatIDsUseCase{
    private let repository: ChatRepository
    init(repository: ChatRepository) {
        self.repository = repository
    }
    func execute(userID: String, completion: @escaping (Result<[String], Error>) -> Void){
        repository.fetchUserChatIDs(userID: userID, completion: completion)
    }
}
