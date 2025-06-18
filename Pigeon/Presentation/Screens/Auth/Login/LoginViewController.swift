

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
            self.loginButton.resetToOriginalState(title: "Login")
        }

        viewModel.onError = { error in
            self.loginButton.shake()
            self.loginButton.resetToOriginalState(title: "Login")
            self.handleLoginError(error: error)
        }
    }
    
    @IBAction func loginButtonPress(_ sender: CustomButton) {
        guard let mail = mailTextField.text, mail.isNotEmpty else{mailTextField.showError(message: ValidationError.emptyEmail.localizedDescription); sender.shake(); return}
        mailTextField.hideError()
        guard let password = passwordTextField.text, password.isNotEmpty else {passwordTextField.showError(message: ValidationError.emptyPassword.localizedDescription); sender.shake(); return}
        sender.resetToOriginalState(title: "Login")
        sender.showLoading(true)
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
    @IBAction func signUpPress(_ sender: UIButton) {
        self.onRegister?()
    }
    
    func handleLoginError(error: Error) {
        let authError = AuthError(from: error)
        print(authError)
        switch authError {
        case .invalidEmail:
            mailTextField.showError(message: error.localizedDescription)
        case .wrongPassword:
            passwordTextField.showError(message: error.localizedDescription)
        case .userNotFound:
            mailTextField.showError(message: error.localizedDescription)
        default:
            showErrorPopup(message: error.localizedDescription)
        }
    }
    func showErrorPopup(title: String = "Error", message: String, completion: (() -> Void)? = nil) {
           let alert = UIAlertController(title: title,
                                         message: message,
                                         preferredStyle: .alert)
           
           alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
               completion?()
           })
           
           self.present(alert, animated: true, completion: nil)
       }
}
