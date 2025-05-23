
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
            self.fieldForFirebaseError(error)
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
    
    func fieldForFirebaseError(_ error: Error) {
        let appError = AppError.handle(error)

        switch appError {
        case .auth(let authError):
            switch authError{
                
            case .invalidEmail,.emailAlreadyInUse,.emailEmpty:
                mailTextField.showError(message: authError.localizedDescription)
            case .wrongPassword,.weakPassword,.passwordEmpty:
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
    
    @IBAction func backToLoginPress(_ sender: UIButton) {
        self.onLogin?()
    }
}
