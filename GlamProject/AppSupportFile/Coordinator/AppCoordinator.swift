
import UIKit


protocol AppMainCooridnatorProtocol : AnyObject{
    var appMainRouter : Router { get }
    
    var tabBarCoordinator : TabBarMasterCoordinator? { get }
 
    
    func start()

}



protocol Coordinator : AnyObject {
    
    var childCoordinator : [Coordinator] { get set }
    
    func start()

}



//앱 댈리게이트에서 사용할 최초의 코디네이터
class AppMainCoordinator : AppMainCooridnatorProtocol {
    
    
    var appMainRouter : Router
    
    var tabBarCoordinator : TabBarMasterCoordinator?
    
    var childCoordinators = [Coordinator]()
    
    required init(_ navigationController: UINavigationController) {
        self.appMainRouter = Router(navigationController: navigationController , navigationBarHidden : true)
    }
    
    func start() {
        tabBarStart()
    }
    
    
    func tabBarStart() {
        
        let tabBarCoordinator = TabBarMasterCoordinator(self)
        self.tabBarCoordinator = tabBarCoordinator
        childCoordinators.append(tabBarCoordinator)
        tabBarCoordinator.start()
    }
    
    
}


