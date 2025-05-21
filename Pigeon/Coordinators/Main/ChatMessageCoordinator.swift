//
//  ChatMessageCoordinator.swift
//  Pigeon
//
//  Created by Muhammet Emre Kemancı on 18.05.2025.
//
import UIKit
class ChatMessageCoordinator: CoordinatorProtocol{
    var navigationController: UINavigationController
    var chat: ChatCredentials?
    var reciverId: String?
    private let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = storyBoard.instantiateViewController(withIdentifier: "ChatMessageViewController") as! ChatMessageViewController
        vc.chat = chat
        vc.reciverId = reciverId
        navigationController.pushViewController(vc, animated: true)
        
    }
    
    
}
