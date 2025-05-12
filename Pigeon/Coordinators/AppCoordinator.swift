//
//  AppCoordinator.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 3.05.2025.
//

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
        if Auth.auth().currentUser != nil {
            showMainFlow()
        } else {
            showAuthFlow()
        }
    }

    func showAuthFlow() {
        let coordinator = AuthCoordinator(navigationController: navigationController)
        self.authCoordinator = coordinator

        coordinator.onFinish = { [weak self] in
            self?.showMainFlow()
        }

        coordinator.start()
    }

    func showMainFlow() {
        let coordinator = MainCoordinator(navigationController: navigationController)
        self.mainCoordinator = coordinator

        coordinator.onLogout = { [weak self] in
            self?.showAuthFlow()
        }

        coordinator.start()
    }
}
