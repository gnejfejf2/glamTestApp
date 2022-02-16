import UIKit

protocol ProfieCoordinatorProtocol {
//    func simpleViewOpen()
}

class ProfileViewCoordinator :  ProfieCoordinatorProtocol {
    
   
    var tabBarCoordinator : TabViewCoordinator?
    
    
    
    func start() {
        let view = ProfileViewController()
        let viewModel = ProfileViewModel()
        viewModel.coordinator = self
        view.viewModel = viewModel
        
        tabBarCoordinator?.tabBaseRouter.push(view, isAnimated: true, onNavigationBack: nil)
    }
 
}
