
import Foundation
import UIKit

protocol TalkTabCoordinatorProtocol {
//    func simpleViewOpen()
}

class TalkViewCoordinator : TabViewCoordinator , TalkTabCoordinatorProtocol {
    
    var tabBarPage: TabBarPage
    
    var tabBarCoordinator: TabBarMasterCoordinator
    
    var navigatonController : UINavigationController =  UINavigationController()
    
    var childCoordinator : [Coordinator] = []
    
    var tabBaseRouter : Router
    
    init(_ tabBarCoordinator : TabBarMasterCoordinator , _ page : TabBarPage){
        self.tabBarCoordinator = tabBarCoordinator
        self.tabBarPage = page
        self.tabBaseRouter = Router(navigationController: navigatonController, navigationBarHidden: true)
    }
    
    func start() {
        let view = TalkViewController()
        let viewModel = TalkViewModel(coordinator:  self)
        viewModel.coordinator = self
        view.viewModel = viewModel
        navigatonController.tabBarItem = tabBarPage.getTabBarItem()
        navigatonController.pushViewController(view, animated: true)
    }
 
    
}
