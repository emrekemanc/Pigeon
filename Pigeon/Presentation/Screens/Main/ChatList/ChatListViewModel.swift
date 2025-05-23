//
//  ChatListViewModel.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 16.05.2025.
//

import Foundation


class ChatListViewModel{
    private let fetchCurrentUser: FetchUserIdUseCase = FetchUserIdUseCase(repository: AuthRepositoryImpl())
    private let fetchAllChatsId: FetchUserChatIDsUseCase = FetchUserChatIDsUseCase(repository: ChatRepositoryImpl())
    private let fetchChat: FetchChatUseCase = FetchChatUseCase(repository: ChatRepositoryImpl())
    private let fetchUser: FetchUserUseCase = FetchUserUseCase(repository: UserRepositoryImpl())
    var onError: ((Error)->Void)?
    var onFetchSuccess: (([String]) -> Void)?
    var onFetchUserContent: ((UserCredentials)-> Void)?
    var onFetchChat: ((ChatCredentials) -> Void)?
    var onCurrentUserId: ((String) -> Void)?
    
    
    func fetchChatsId(currentUser: String){
        fetchAllChatsId.execute(userID: currentUser) {[weak self] result in
            switch result{
            case .success(let chatsIds):
                self?.onFetchSuccess?(chatsIds)
            case .failure(let error):
                self?.onError?(error)
            }
        }
    }
    func fetchCurentUser(){
        fetchCurrentUser.execute { [weak self] result in
            switch result{
            case .success(let uid):
                self?.onCurrentUserId?(uid)
                self?.fetchChatsId(currentUser: uid)
                print("Fetch Current user")
            case .failure(let error):
                self?.onError?(error)
            }
        }
    }
    func startFetch(){
        fetchCurentUser()
    }
    
    func fetchChatContent(chat_id: String, current_uid: String ){
        fetchChat.execute(by: chat_id) {[weak self]  result in
            switch result{
            case .success(let chat):
                self?.receiverContent(chat: chat, current_uid: current_uid)
            case .failure(let error):
                self?.onError?(error)
            }
        }
    }
    func receiverContent(chat: ChatCredentials, current_uid: String){
        if chat.user1_id == current_uid{
            self.fetchUserContent(uid: chat.user2_id)
        } else if chat.user2_id == current_uid{
            self.fetchUserContent(uid: chat.user1_id)
        }else{
            
        }
    }
    func fetchUserContent(uid: String){
        self.fetchUser.execute(uid: uid) {[weak self] result in
            switch result{
            case .success(let receiver):
                self?.onFetchUserContent?(receiver)
            case .failure(let error):
                self?.onError?(error)
            }
        }
    }
    func chatFetch(chat_id: String){
        fetchChat.execute(by: chat_id) {[weak self] result in
            switch result{
            case .success(let chat):
                self?.onFetchChat?(chat)
            case .failure(let error):
                self?.onError?(error)
            }
        }
    }
}
