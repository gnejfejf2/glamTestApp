import UIKit

protocol HomeTabCoordinatorProtocol {
//    func simpleViewOpen()
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
        let viewModel = HomeViewModel(coordinator:  self)
        viewModel.coordinator = self
        view.viewModel = viewModel
        navigatonController.tabBarItem = tabBarPage.getTabBarItem()
        
        navigatonController.pushViewController(view, animated: true)
    }
 
    
    func dommyViewOpen(){
        
        let vc = UIViewController()
        let red = CGFloat(arc4random_uniform(256)) / 255
        let green = CGFloat(arc4random_uniform(256)) / 255
        let blue = CGFloat(arc4random_uniform(256)) / 255

        vc.view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1)

        let label = UILabel()
        label.text = "123123"
        label.font = .systemFont(ofSize: 56, weight: .bold)
        
        vc.view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        navigatonController.pushViewController(vc, animated: true)
        
        
    }
    
    
}
