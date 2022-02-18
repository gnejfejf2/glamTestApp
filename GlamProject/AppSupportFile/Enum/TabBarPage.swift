
import Foundation
import UIKit


enum TabBarPage {
    case Home
    case Play
    case Favorite
    case Talk
    case My

    init?(index: Int) {
        switch index {
        case 0:
            self = .Home
        case 1:
            self = .Play
        case 2:
            self = .Favorite
        case 3:
            self = .Talk
        case 4:
            self = .My
        default:
            return nil
        }
    }
    
    func pageTitleValue() -> String {
        switch self {
        case .Home:
            return "Home"
        case .Play:
            return "Play"
        case .Favorite:
            return "Favorite"
        case .Talk:
            return "Talk"
        case .My:
            return "My"
        }
    }

    func getTabBarItem() -> UITabBarItem {
        switch self {
        case .Home:
            return UITabBarItem(title: nil, image: UIImage(named: "home"), tag: self.pageOrderNumber())
        case .Play:
            return UITabBarItem(title: nil, image: UIImage(named: "live"), tag: self.pageOrderNumber())
        case .Favorite:
            return UITabBarItem(title: nil, image: UIImage(named: "station"), tag: self.pageOrderNumber())
        case .Talk:
            return UITabBarItem(title: nil, image: UIImage(named: "connection"), tag: self.pageOrderNumber())
        case .My:
            return UITabBarItem(title: nil, image: UIImage(named: "more"), tag: self.pageOrderNumber())
        }
    }
    
    func pageOrderNumber() -> Int {
        switch self {
        case .Home:
            return 0
        case .Play:
            return 1
        case .Favorite:
            return 2
        case .Talk:
            return 3
        case .My:
            return 4
        }
    }
}
