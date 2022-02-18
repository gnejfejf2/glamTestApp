import UIKit

protocol HomeTabCoordinatorProtocol {

}

class HomeViewCoordinator : TabViewCoordinator , HomeTabCoordinatorProtocol {
    
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
        let view = HomeViewController()
        let viewModel = HomeViewModel()
        viewModel.coordinator = self
        view.viewModel = viewModel
        navigatonController.tabBarItem = tabBarPage.getTabBarItem()
        
        navigatonController.pushViewController(view, animated: true)
    }
 
    
    func profileViewOpen(){
        let coordinator = ProfileViewCoordinator()
        coordinator.tabBarCoordinator = self
        coordinator.start()
        
        
    }
    
  
    
    
}
