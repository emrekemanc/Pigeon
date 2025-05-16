
import UIKit

class RegisterViewController: UIViewController{
    @IBOutlet weak var mailTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    @IBOutlet weak var fullnameTextField: CustomTextField!
    private let viewModel: RegisterViewModel = RegisterViewModel()
    var onRegisterSuccess: (() -> Void)?
    var onLogin: (() -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        registerConfiguration()    }
    
    func registerConfiguration(){
        viewModel.onSuccess = { success in
            print(success)
            self.onRegisterSuccess?()
            
        }
        viewModel.onError = {error in
          let error = AuthError(from: error)
            print(error.localizedDescription)
            
        }
    }
    @IBAction func registerButtonPress(_ sender: CustomButton) {
        guard let fullname = fullnameTextField.text, fullname.isNotEmpty else{fullnameTextField.showError(message: UserError.fullnameEmpity.localizedDescription); return}
            fullnameTextField.hideError()
        
        guard let mail = mailTextField.text, mail.isNotEmpty else{mailTextField.showError(message: AuthError.emailEmpty.localizedDescription); return}
            mailTextField.hideError()
        
        guard let password = passwordTextField.text, password.isNotEmpty else{passwordTextField.showError(message: AuthError.passwordEmpty.localizedDescription); return}
            passwordTextField.hideError()
        
        let register = AuthCredentials(email: mail, password: password)
        let user = UserCredentials(fullname: fullname, mail: mail, created_at: Date(), updated_at: Date())
        viewModel.register(authCredentials: register, userCredentials: user)
    }
    
    @IBAction func backToLoginPress(_ sender: UIButton) {
        self.onLogin?()
    }
}
