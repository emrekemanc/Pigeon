

import UIKit
import FirebaseAuth

class AppCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController
    var authCoordinator: AuthCoordinator?
    var mainCoordinator: MainCoordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        authCoordinator = AuthCoordinator(navigationController: navigationController)
        authCoordinator?.onLoginSuccess = {
            self.showMain()
        }
        mainCoordinator = MainCoordinator(navigationController: navigationController)
        mainCoordinator?.onLogout = {
            self.showAuth()
        }
        
        if isUserLogin(){
            showMain()
        }else{
            showAuth()
        }
        
    }
    
    func showAuth(){
        authCoordinator?.start()
    }
    func showMain(){
        mainCoordinator?.start()
    }
    
   private func isUserLogin() -> Bool{
        return Auth.auth().currentUser != nil
    }

 
}
