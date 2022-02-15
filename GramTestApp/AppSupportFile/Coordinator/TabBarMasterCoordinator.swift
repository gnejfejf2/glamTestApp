import UIKit

protocol TabBarMasterProtocol {
    
    var appMainCoordinator : AppMainCoordinator { get }
    
    var tabBarController: UITabBarController { get }

    
    func prepareTabBarController(withTabControllers tabControllers: [UIViewController])
}


class TabBarMasterCoordinator: NSObject, Coordinator , TabBarMasterProtocol {
    
    let tabBarController : UITabBarController = .init()
    
    let appMainCoordinator : AppMainCoordinator
    
    var childCoordinator: [Coordinator] = []
    

    required init(_ appMainCoordinator : AppMainCoordinator){
    
        self.appMainCoordinator = appMainCoordinator
    
    }
    
    func start() {
        // 탭바를 사용한다면 여기에 페이지를 추가하면된다.
        let pages: [TabBarPage] = [.Home , .Play , .Favorite , .Talk ,.My]
            .sorted(by: { $0.pageOrderNumber() < $1.pageOrderNumber() })
        
        // Initialization of ViewControllers or these pages
        let controllers : [UINavigationController] = pages.map({ getTabController($0).navigatonController })
//
        
        prepareTabBarController(withTabControllers: controllers)
    }
    
    
    func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
        
        tabBarController.delegate = self
        
        tabBarController.setViewControllers(tabControllers, animated: true)
        //최초 선택값 셋팅
        tabBarController.selectedIndex = TabBarPage.Home.pageOrderNumber()
        tabBarController.tabBar.tintColor = .black
        tabBarController.tabBar.backgroundColor = .white
        appMainCoordinator.appMainRouter.push(tabBarController, isAnimated: false, onNavigationBack: nil)
     
    }
    
    func getTabController(_ page: TabBarPage) -> TabViewCoordinator {
        

        switch page {
        case .Home:
            // If needed: Each tab bar flow can have it's own Coordinator.
            let coordinator = HomeViewCoordinator(self , page)
          
            childCoordinator.append(coordinator)
            
            coordinator.start()
            return coordinator
        case .Play:
            let coordinator = PlayViewCoordinator(self , page)
            childCoordinator.append(coordinator)
            
            coordinator.start()
            return coordinator
        case .Favorite:
            let coordinator = FavoriteViewCoordinator(self , page)
            childCoordinator.append(coordinator)
        
            coordinator.start()
            return coordinator
        case .Talk:
            let coordinator = TalkViewCoordinator(self , page)
            childCoordinator.append(coordinator)
        
            coordinator.start()
            return coordinator
        case .My:
            let coordinator = MyViewCoordinator(self , page)
            childCoordinator.append(coordinator)
        
            coordinator.start()
            return coordinator
        }
        
  
    }
    
    
}

// MARK: - UITabBarControllerDelegate
extension TabBarMasterCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {
//        print(tabBarController.selectedIndex)
    }
}
