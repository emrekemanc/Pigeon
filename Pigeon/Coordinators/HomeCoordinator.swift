
import UIKit

class HomeCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController
    var onLogout: (() -> Void)?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
        vc.onLogout = {
            self.onLogout?()
        }
        navigationController.setViewControllers([vc], animated: true)
    }
}
