

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
        userLogin()
      
        
    }
    func showVerify(){
        authCoordinator?.showVerify()
    }
    func showAuth(){
        authCoordinator?.start()
    }
    func showMain(){
        mainCoordinator?.start()
    }
    
    private func userLogin(){
    
       if Auth.auth().currentUser != nil {
           if Auth.auth().currentUser!.isEmailVerified  {
               print("Kullanıcı var ve doğrulanmış")
               self.showMain()
           }else{
               print("kullanıcı var ve doğrulanmamış")
               self.showVerify()
           }
       }else {
           print("kullanıcı yok")
           self.showAuth()
       }
    }
    func handleEmailVerified(uid: String) {
            Auth.auth().currentUser?.reload(completion: { error in
                if error == nil, Auth.auth().currentUser?.isEmailVerified == true {
                    DispatchQueue.main.async {
                        print("doğrulama başarı ile oldu\(uid)")
                        self.showMain()
                    }
                } else {
                    print(error?.localizedDescription)
                }
            })
        }

 
}
