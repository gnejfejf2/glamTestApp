//
//  FavoriteViewCoordinator.swift
//  GramTestApp
//
//  Created by Hwik on 2022/02/14.
//

import Foundation
import UIKit
protocol FavoriteTabCoordinatorProtocol {
//    func simpleViewOpen()
}

class FavoriteViewCoordinator : TabViewCoordinator , FavoriteTabCoordinatorProtocol {
    
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
        let view = FavoriteViewController()
        let viewModel = FavoriteViewModel(coordinator:  self)
        viewModel.coordinator = self
        view.viewModel = viewModel
        navigatonController.tabBarItem = tabBarPage.getTabBarItem()
        navigatonController.pushViewController(view, animated: true)
    }
 
    
}
