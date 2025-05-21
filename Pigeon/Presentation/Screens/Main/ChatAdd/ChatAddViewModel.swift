//
//  ChatViewModel.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 18.05.2025.
//

import Foundation

class ChatAddViewModel{
    var onSuccess: (([UserCredentials]) -> Void)?
    var chatCheck:((ChatCredentials?,String) ->Void)?
    var onError: ((Error) -> Void)?
    private let searchUseCase: SearchUserUseCase = SearchUserUseCase(repository: UserRepositoryImpl())
    private let fetchUserIdUseCase: FetchUserIdUseCase = FetchUserIdUseCase(repository: AuthRepositoryImpl())
    private let checkChatUseCase: CheckIfChatExistsUseCase = CheckIfChatExistsUseCase(repository: ChatRepositoryImpl())

    func searchUser(mail: String){
        searchUseCase.execute(mail: mail) { result in
            switch result{
            case .success(let users):
                self.onSuccess?(users)
            case .failure(let error):
                self.onError?(error)
            }
        }
    }
    
    func checkChat(user2Id: String){
        fetchUserIdUseCase.execute { result in
            switch result {
            case .success(let user1Id):
                self.checkChatUseCase.execute(
                    between: ChatCredentials(user1_id: user1Id, user2_id: user2Id, created_at: Date(), messages_ids: [])
                ) { result in
                    switch result {
                    case .success(let chat):
                        self.chatCheck?(chat,user2Id)
                    case .failure(let error):
                        self.onError?(error)
                    }
                }
            case .failure(let error):
                self.onError?(error)
            }
        }
    }
    
}
