
import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var mailTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    @IBOutlet weak var fullnameTextField: CustomTextField!
    @IBOutlet weak var registerButton: CustomButton!
    private let viewModel: RegisterViewModel = RegisterViewModel()
    var onRegisterSuccess: (() -> Void)?
    var onLogin: (() -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        registerConfiguration()

        fullnameTextField.delegate = self
        mailTextField.delegate = self
        passwordTextField.delegate = self

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    func registerConfiguration(){
        viewModel.onSuccess = { success in
            print(success)
            self.registerButton.resetToOriginalState(title: "Register")
            self.onRegisterSuccess?()
            
        }
        viewModel.onError = {error in
            self.registerButton.resetToOriginalState(title: "Register")
            self.registerButton.shake()
            self.handleLoginError(error: error)
        }
    }
    
    
    @IBAction func registerButtonPress(_ sender: CustomButton) {
        guard validateValue() else{sender.shake(); return}
        let mail = mailTextField.text!
        let fullname = fullnameTextField.text!
        let password = passwordTextField.text!
        sender.showLoading(true)
        viewModel.register(authCredentials: AuthCredentials(email: mail, password: password), userCredentials: UserCredentials(fullname: fullname, email: mail.lowercased(), created_at: Date(), updated_at: Date(), chat_ids: []))
        
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == fullnameTextField {
            mailTextField.becomeFirstResponder()
        } else if textField == mailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
            registerButtonPress(registerButton)
        }
        return true
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func validateValue() -> Bool{
        if let error = fullnameTextField.text?.isValidFullname(){
            fullnameTextField.showError(message: error.localizedDescription)
            return false
        }
        fullnameTextField.hideError()
        if let error = mailTextField.text?.isValidEmail(){
            mailTextField.showError(message: error.localizedDescription)
            return false
        }
        mailTextField.hideError()
        if let error = passwordTextField.text?.isValidPassword(){
            passwordTextField.showError(message: error.localizedDescription)
            return false
        }
        passwordTextField.hideError()
        return true
    }
    
    func handleLoginError(error: Error) {
        print(error.localizedDescription)
        let authError: AuthError = error as! AuthError
        switch authError {
        case .emailAlreadyInUse:
            mailTextField.showError(message: authError.localizedDescription)
        case .invalidEmail:
            mailTextField.showError(message: authError.localizedDescription)
        case .weakPassword:
            passwordTextField.showError(message: authError.localizedDescription)
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
    @IBAction func backToLoginPress(_ sender: UIButton) {
        self.onLogin?()
    }
}
