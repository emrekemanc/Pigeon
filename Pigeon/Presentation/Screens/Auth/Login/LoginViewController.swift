

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var mailTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    private let viewModel: LoginViewModel = LoginViewModel()
    var onLoginSuccess: (() -> Void)?
    var onRegister: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        loginConfiguration()
    }

    func loginConfiguration() {
        viewModel.onSuccess = { [weak self] success in
            print(success)
            self?.onLoginSuccess?()
        }

        viewModel.onError = { error in
            let error = AuthError(from: error)
            if error == .invalidEmail{
                self.mailTextField.showError(message: error.localizedDescription)
            }
            if error == .wrongPassword{
                self.passwordTextField.showError(message: error.localizedDescription)
            }
            
        }
    }
    
    @IBAction func loginButtonPress(_ sender: CustomButton) {
        guard let mail = mailTextField.text, mail.isNotEmpty else{mailTextField.showError(message: AuthError.emailEmpty.localizedDescription); return}
            mailTextField.hideError()
        guard let password = passwordTextField.text, password.isNotEmpty else{passwordTextField.showError(message: AuthError.passwordEmpty.localizedDescription); return}
        passwordTextField.hideError()
            
        let loginModel = AuthCredentials(email: mail, password: password)
        viewModel.login(with: loginModel)
    }
    @IBAction func mailViewer(_ sender: CustomTextField) {
        
    }
    
    @IBAction func signUpPress(_ sender: UIButton) {
        self.onRegister?()
    }
}
