

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
        if isUserLogin(){
            showMain()
        }else{
            showAuth()
        }
    }
    
    func showAuth(){
        authCoordinator = AuthCoordinator(navigationController: navigationController)
        authCoordinator?.onLoginSuccess = {
            self.showMain()
        }
        authCoordinator?.start()
    }
    func showMain(){
        mainCoordinator = MainCoordinator(navigationController: navigationController)
        mainCoordinator?.onLogout = {
            self.showAuth()
        }
        mainCoordinator?.start()
    }
   private func isUserLogin() -> Bool{
        return Auth.auth().currentUser != nil
    }

 
}
