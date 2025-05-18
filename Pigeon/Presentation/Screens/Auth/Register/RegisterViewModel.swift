
import Foundation

final class RegisterViewModel {
    var onSuccess: ((Bool) -> Void)?
    var onError: ((Error) -> Void)?

    private let registerUseCase = RegisterUserUseCases(repository: AuthRepositoryImpl())
    private let createUserUseCase = CreateUserUseCase(repository: UserRepositoryImpl())
    private let deleteUseCase = DeleteUseCase(repository: AuthRepositoryImpl())
    private let signOutUseCase = SignOutUseCase(repository: AuthRepositoryImpl())
    private let loginUseCase = LoginUserUseCases(repository: AuthRepositoryImpl())

    func register(authCredentials: AuthCredentials, userCredentials: UserCredentials) {
        
        registerUseCaseFunc(authCredentials: authCredentials, userCredentials: userCredentials)
        
    }
   
    private func registerUseCaseFunc(authCredentials: AuthCredentials, userCredentials: UserCredentials) {
        registerUseCase.execute(authCredentials: authCredentials) { result in
            switch result {
            case .success(let uid):
                var updatedUserCredentials = userCredentials
                updatedUserCredentials.id = uid
                self.loginUseCaseFunc(authCredentials: authCredentials, userCredentials: updatedUserCredentials)
            case .failure(let error):
                print("Register Error: \(error.localizedDescription)")
                self.handleError(error)
            }
        }
    }

    private func loginUseCaseFunc(authCredentials: AuthCredentials, userCredentials: UserCredentials) {
        loginUseCase.execute(authCredentials: authCredentials) { result in
            switch result {
            case .success:
                self.createUserUseCaseFunc(userCredentials: userCredentials)
            case .failure(let error):
                print("Login Error: \(error.localizedDescription)")
                self.handleError(error)
            }
        }
    }

    private func createUserUseCaseFunc(userCredentials: UserCredentials) {
        createUserUseCase.execute(userCredentials: userCredentials) { result in
            switch result {
            case .success:
                self.signOutUseCaseFunc()
            case .failure(let error):
                print("Create User Error: \(error.localizedDescription)")
                self.signOutUseCaseFunc()
                self.deleteUserUseCaseFunc()
                self.handleError(error)
            }
        }
    }

    private func deleteUserUseCaseFunc() {
        deleteUseCase.execute { result in
            switch result {
            case .success:
                print("Kullanıcı silindi")
            case .failure(let error):
                print("Kullanıcı silinemedi: \(error.localizedDescription)")
                self.handleError(error)
            }
        }
    }

    private func signOutUseCaseFunc() {
        signOutUseCase.execute { result in
            switch result {
            case .success(let result):
                self.onSuccess?(result)
            case .failure(let error):
                print("Sign Out Error: \(error.localizedDescription)")
                self.handleError(error)
            }
        }
    }
    private func handleError(_ error: Error) {
        let convertedError = AuthError(from: error)
        print("Error: \(convertedError.localizedDescription)")
        self.onError?(convertedError)
    }
}
