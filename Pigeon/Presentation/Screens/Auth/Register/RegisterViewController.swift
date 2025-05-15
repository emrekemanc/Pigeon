
import UIKit

class RegisterViewController: UIViewController{
    private let viewModel: RegisterViewModel = RegisterViewModel()
    var onRegisterSuccess: (() -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        registerConfiguration()
        viewModel.register(with: AuthCredentials(email: "emrekemanci@gmail.com", password: "Emre.emre23"))
    }
    
    func registerConfiguration(){
        viewModel.onSuccess = { success in
            print(success)
            
        }
        viewModel.onError = {error in
            print(error.localizedDescription)
            
        }
    }
}
