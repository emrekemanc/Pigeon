//
//  SettingsViewModel.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 16.05.2025.
//

import Foundation

class SettingsViewModel{
    var onSuccess: ((Bool) -> Void)?
    var onError: ((Error) -> Void)?
    var onfetchUser: ((UserCredentials) -> Void)?
    private let signOutUseCase: SignOutUseCase = SignOutUseCase(repository: AuthRepositoryImpl())
    private let fetchCurrentUser: FetchUserIdUseCase = FetchUserIdUseCase(repository: AuthRepositoryImpl())
    private let fetchUserUseCase: FetchUserUseCase = FetchUserUseCase(repository: UserRepositoryImpl())
    
    func signOut(){
        signOutUseCase.execute {[weak self] result in
            switch result{
            case .success(let e):
                self?.onSuccess?(e)
            case .failure(let error):
                self?.onError?(error)
            }
        }
    }
    func fetchUser(){
        fetchCurrentUser.execute {[weak self] result in
            switch result{
            case .success(let uid):
                self?.fetchUserUseCase.execute(uid: uid) { [weak self] resultt in
                    switch resultt {
                    case .success(let user):
                        self?.onfetchUser?(user)
                    case .failure(let error):
                        self?.onError?(error)
                    }
                }
            case .failure(let error):
                self?.onError?(error)
            }
        }
    }
    
}
