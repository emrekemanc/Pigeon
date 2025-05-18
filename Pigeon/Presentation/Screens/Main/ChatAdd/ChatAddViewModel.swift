//
//  ChatViewModel.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 18.05.2025.
//

class ChatAddViewModel{
    var onSuccess: (([UserCredentials]) -> Void)?
    var onError: ((Error) -> Void)?
    private let searchUseCase: SearchUserUseCase = SearchUserUseCase(repository: UserRepositoryImpl())
    
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
}
