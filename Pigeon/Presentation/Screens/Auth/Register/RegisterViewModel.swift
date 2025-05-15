
import Foundation
final class RegisterViewModel{
    var onSuccess: ((Bool) -> Void)?
    var onError: ((Error) -> Void)?
    
    private let registerUseCase = RegisterUserUseCases(repository: AuthRepositoryImpl())
    func register(with authCredentials: AuthCredentials){
        if let validationError = authCredentials.validationError{
            onError?(AppError.auth(validationError))
        }
        
        registerUseCase.execute(authCredentials: authCredentials) { [weak self] result in
            DispatchQueue.main.async {
                switch result{
                case .success(let result):
                    self?.onSuccess?(result)
                case .failure(let error):
                    self?.onError?(error)
                }
            }
        }
    }
}
