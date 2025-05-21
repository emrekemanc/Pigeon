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
        vc.tabBarItem = UITabBarItem(title: "Chat", image: UIImage(systemName: "gearshape"), tag: 0)
        navigationController.setViewControllers([vc], animated: false)
    }
    
    
}
