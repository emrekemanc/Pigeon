

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var mailTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    @IBOutlet weak var loginButton: CustomButton!
    private let viewModel: LoginViewModel = LoginViewModel()
    var onLoginSuccess: (() -> Void)?
    var onRegister: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        mailTextField.delegate = self
        passwordTextField.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        loginConfiguration()
    }

    func loginConfiguration() {
        viewModel.onSuccess = { success in
            self.onLoginSuccess?()
            self.loginButton.showLoading(false, disableWhileLoading: false)
        }

        viewModel.onError = { error in
            self.loginButton.shake()
            self.loginButton.showLoading(false, disableWhileLoading: false)
            self.fieldForFirebaseError(error)
            
        }
    }
    
    @IBAction func loginButtonPress(_ sender: CustomButton) {
        guard let mail = mailTextField.text, mail.isNotEmpty else{mailTextField.showError(message: ValidationError.emptyEmail.localizedDescription); sender.shake(); return}
        mailTextField.hideError()
        guard let password = passwordTextField.text, password.isNotEmpty else {passwordTextField.showError(message: ValidationError.emptyPassword.localizedDescription); sender.shake(); return}
        sender.showLoading(true, disableWhileLoading: true)
        viewModel.login(with: AuthCredentials(email: mail.lowercased(), password: password))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == mailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
            loginButtonPress(loginButton)
        }
        return true
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    @IBAction func mailViewer(_ sender: CustomTextField) {
        
    }
    func fieldForFirebaseError(_ error: Error) {
        let appError = AppError.handle(error)
        switch appError {
        case .auth(let authError):
            switch authError{
            case .invalidEmail:
                mailTextField.showError(message: authError.localizedDescription)
            case .wrongPassword:
                passwordTextField.showError(message: authError.localizedDescription)
            default:
                print(authError.localizedDescription)
                break
            }
        default:
            print(appError.localizedDescription)
            break
            
        }
   
        
    }
    @IBAction func signUpPress(_ sender: UIButton) {
        self.onRegister?()
    }
    
}
