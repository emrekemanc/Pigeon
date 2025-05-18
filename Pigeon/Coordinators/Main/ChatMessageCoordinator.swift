//
//  ChatMessageCoordinator.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 18.05.2025.
//
import UIKit
class ChatMessageCoordinator: CoordinatorProtocol{
    var navigationController: UINavigationController
    private let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = storyBoard.instantiateViewController(withIdentifier: "ChatMessageViewController") as! ChatMessageViewController
        navigationController.pushViewController(vc, animated: true)
        
    }
    
    
}
