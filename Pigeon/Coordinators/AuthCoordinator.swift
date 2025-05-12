//
//  AuthCoordinator.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 12.05.2025.
//

import UIKit

class AuthCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController
    var onFinish: (() -> Void)?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let loginVC = LoginViewController()
        loginVC.onLoginSuccess = { [weak self] in
            self?.onFinish?()
        }
        navigationController.setViewControllers([loginVC], animated: true)
    }
}
