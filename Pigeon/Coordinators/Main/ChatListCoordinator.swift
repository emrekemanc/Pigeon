//
//  ChatListCoordinator.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 18.05.2025.
//

import UIKit

class ChatListCoordinator: CoordinatorProtocol{
    private let storyBoard = UIStoryboard(name: "Main", bundle: nil)

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    var navigationController: UINavigationController
    
    func start() {
        let vc = storyBoard.instantiateViewController(withIdentifier: "ChatListViewController") as! ChatListViewController
        vc.title = "PIGEON"
        vc.tabBarItem = UITabBarItem(title: "Chat", image: UIImage(systemName: "message"), tag: 0)
        vc.tabBarItem.badgeColor = UIColor(.pigeonDark)
        navigationController.setViewControllers([vc], animated: false)
    }
    
    
}
