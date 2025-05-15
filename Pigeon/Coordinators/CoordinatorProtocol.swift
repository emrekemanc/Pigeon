
import UIKit

protocol CoordinatorProtocol: AnyObject{
    var navigationController: UINavigationController {get set}
    func start()
}
