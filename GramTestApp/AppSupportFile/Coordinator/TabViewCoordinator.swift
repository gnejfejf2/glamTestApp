//
//  TabViewCoordinator.swift
//  GramTestApp
//
//  Created by Hwik on 2022/02/14.
//

import Foundation
import UIKit

protocol TabViewCoordinator : Coordinator {
    var tabBarCoordinator : TabBarMasterCoordinator { get }
    
    var navigatonController : UINavigationController { get }
    
    var tabBarPage : TabBarPage { get }
    
    var tabBaseRouter : Router { get }
}
