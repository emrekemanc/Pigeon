//
//  MainCoordinator.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 12.05.2025.
//

import UIKit

class MainCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController
    var onLogout: (() -> Void)?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let homeVC = HomeViewController()
        homeVC.onLogout = { [weak self] in
            self?.onLogout?()
        }
        
        navigationController.setViewControllers([homeVC], animated: true)
    }
}
