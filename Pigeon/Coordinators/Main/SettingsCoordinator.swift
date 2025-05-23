//
//  SettingsCoordinator.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 18.05.2025.
//
import UIKit
class SettingsCoordinator: CoordinatorProtocol{
    var navigationController: UINavigationController
    var onLogOut: (() -> Void)?
   private let storyboard = UIStoryboard(name: "Main", bundle: nil)
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {
        let vc = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        vc.onSignOut = {
            self.onLogOut?()
        }
        vc.title = "PIGEON"
        vc.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gearshape"), tag: 2)
        vc.tabBarItem.badgeColor = UIColor(.pigeonDark)
        navigationController.setViewControllers([vc], animated: false)
    }
    
    
}
