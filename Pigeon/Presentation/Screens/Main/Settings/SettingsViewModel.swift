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
    private let signOutUseCase = SignOutUseCase(repository: AuthRepositoryImpl())
    
    func signOut(){
        signOutUseCase.execute { result in
            switch result{
            case .success(let e):
                self.onSuccess?(e)
            case .failure(let error):
                self.onError?(error)
            }
        }
    }
    
}
