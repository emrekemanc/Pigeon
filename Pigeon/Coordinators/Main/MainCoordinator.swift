
import UIKit

class MainCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController
    var tabBarController = UITabBarController()
    var onLogout: (() -> Void)?
    var chatAddCoordinator: ChatAddCoordinator!
    var chatListCoordinator: ChatListCoordinator!
    var settingsCoordinator: SettingsCoordinator!
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
   
    func start() {
            chatAddCoordinator = ChatAddCoordinator(navigationController: UINavigationController())
        chatAddCoordinator.selectedUser = { chat, reciverId in
            self.showChatMessage(chat: chat,reciverId: reciverId)
        }
            chatListCoordinator = ChatListCoordinator(navigationController: UINavigationController())
            settingsCoordinator = SettingsCoordinator(navigationController: UINavigationController())
        settingsCoordinator?.onLogOut = {
            self.onLogout?()
        }
        chatAddCoordinator?.start()
        chatListCoordinator?.start()
        settingsCoordinator?.start()
        
        tabBarController.viewControllers = [chatListCoordinator.navigationController, chatAddCoordinator.navigationController, settingsCoordinator.navigationController]
        navigationController.setViewControllers([tabBarController], animated: true)
    }
    
    func showChatMessage(chat: ChatCredentials?,reciverId: String){
       let chatMessageCoordinator = ChatMessageCoordinator(navigationController: navigationController)
        chatMessageCoordinator.chat = chat
        chatMessageCoordinator.reciverId = reciverId
        chatMessageCoordinator.start()
        
        
    }
}
