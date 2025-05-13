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
            showHomeFlow()
        } else {
            showAuthFlow()
        }
    }

    func showAuthFlow() {
        let coordinator = AuthCoordinator(navigationController: navigationController)
        self.authCoordinator = coordinator

        coordinator.onFinish = { [weak self] in
            self?.showHomeFlow()
        }

        coordinator.start()
    }

    func showHomeFlow() {
        let coordinator = MainCoordinator(navigationController: navigationController)
        self.mainCoordinator = coordinator

        coordinator.onLogout = { [weak self] in
            self?.showAuthFlow()
        }

        coordinator.start()
    }
}
