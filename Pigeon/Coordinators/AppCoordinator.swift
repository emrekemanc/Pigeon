

import UIKit
import FirebaseAuth

class AppCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController
    var authCoordinator: AuthCoordinator?
    var homeCoordinator: HomeCoordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        if isUserLogin(){
            showHome()
        }else{
            showAuth()
        }
    }
    
    func showAuth(){
        authCoordinator = AuthCoordinator(navigationController: navigationController)
        authCoordinator?.onLoginSuccess = {
            self.showHome()
        }
        authCoordinator?.start()
    }
    func showHome(){
        homeCoordinator = HomeCoordinator(navigationController: navigationController)
        homeCoordinator?.onLogout = {
            self.showAuth()
        }
        homeCoordinator?.start()
    }
   private func isUserLogin() -> Bool{
        return Auth.auth().currentUser != nil
    }

 
}
