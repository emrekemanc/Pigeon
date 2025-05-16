
import Foundation
final class RegisterViewModel{
    var onSuccess: ((Bool) -> Void)?
    var onError: ((Error) -> Void)?
    
    private let registerUseCase = RegisterUserUseCases(repository: AuthRepositoryImpl())
    private let createUserUseCase = CreateUserUseCase(repository: UserRepositoryImpl())
    private let deleteUseCase = DeleteUseCase(repository: AuthRepositoryImpl())
    private let signOutUseCase = SignOutUseCase(repository: AuthRepositoryImpl())
    
    func register(authCredentials: AuthCredentials, userCredentials: UserCredentials){
        if let validationError = authCredentials.validationError{
            onError?(AppError.auth(validationError))
        }
        
        registerUseCase.execute(authCredentials: authCredentials) { [weak self] result in
            DispatchQueue.main.async {
                switch result{
                case .success(let e):
                    var updatedCredentials = userCredentials
                    updatedCredentials.id = e
                    self?.createUserUseCase.execute(userCredentials: updatedCredentials) {[weak self] res in
                        switch res{
                        case .success(_):
                            self?.signOutUseCase.execute { re in
                                switch re{
                                case .success(let r):
                        
                                    self?.onSuccess?(r)
                                    
                                case .failure(let error):
                                    self?.onError?(error)
                                }
                            }
                        case .failure(let e):
                            self?.deleteUseCase.execute { r in
                                switch r{
                                case .success(_):
                                    self?.onError?(e)
                                    
                                case .failure(let error):
                                    self?.onError?(error)
                                }
                            }
                        }
                    }
                case .failure(let error):
                    self?.onError?(error)
                }
                
            }
        }
    }
}
