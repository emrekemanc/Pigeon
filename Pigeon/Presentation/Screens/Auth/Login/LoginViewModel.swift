
import Foundation

final class LoginViewModel{
    var onSuccess: ((Bool) -> Void)?
    var onError: ((Error) -> Void)?
    
    private let loginUseCase = LoginUserUseCases(repository: AuthRepositoryImpl())
    private let otpUseCase = OtpUseCase(repository: AuthRepositoryImpl())
    func login(with authCredentials: AuthCredentials){
        loginUseCase.execute(authCredentials: authCredentials) { [weak self] result in
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
    func verifyMail(_ email: String){
        otpUseCase.verifyMailAdress(email) {[weak self] result in
            switch result{
            case .success(let request):
                print(result)
            case .failure(let error):
                self?.onError?(error)
            }
        }
    }
}
