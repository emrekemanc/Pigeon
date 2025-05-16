
import UIKit

class MainCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController
    var onLogout: (() -> Void)?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "MainViewController") as! MainViewController
        navigationController.setViewControllers([vc], animated: true)
    }
    
}
