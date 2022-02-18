

import Foundation
import UIKit

protocol TabViewCoordinator : Coordinator {
    var tabBarCoordinator : TabBarMasterCoordinator { get }
    
    var navigatonController : UINavigationController { get }
    
    var tabBarPage : TabBarPage { get }
    
    var tabBaseRouter : Router { get }
}
