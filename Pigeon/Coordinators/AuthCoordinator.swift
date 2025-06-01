
import UIKit

class AuthCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController
    var onLoginSuccess: (() -> Void)?
    private  let storyboard = UIStoryboard(name: "Auth", bundle: nil)
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showSMSVerification()
    }
    
    func showLogin(){
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        vc.onRegister = {
            self.showRegister()
        }
        vc.onLoginSuccess = {
            self.onLoginSuccess?()
        }
        navigationController.setViewControllers([vc], animated: true)
    }
    
    func showRegister(){
        let vc = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        vc.onRegisterSuccess = {
            self.showLogin()
        }
        vc.onLogin = {
            self.showLogin()
        }
        navigationController.setViewControllers([vc], animated: true)
    }
    func showSMSVerification(){
        let vc = storyboard.instantiateViewController(withIdentifier: "PhoneVerificationViewController") as! PhoneVerificationViewController
        navigationController.setViewControllers([vc], animated: true)
    }
    
}
