//
//  Untitled.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 18.05.2025.
//
import UIKit
class ChatAddCoordinator: CoordinatorProtocol{
    var navigationController: UINavigationController
    var selectedUser: ((ChatCredentials?,String) -> Void)?
    private let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = storyBoard.instantiateViewController(withIdentifier: "ChatAddViewController") as! ChatAddViewController
        vc.userSelected = { chat,reciverId in
            self.selectedUser?(chat,reciverId)
        }
        vc.title = "PIGEON"
        vc.tabBarItem = UITabBarItem(title: "New Chat", image: UIImage(systemName: "plus"), tag: 1)
        vc.tabBarItem.badgeColor = UIColor(.pigeonDark)
        navigationController.setViewControllers([vc], animated: false)
        
    }
    
    
}
