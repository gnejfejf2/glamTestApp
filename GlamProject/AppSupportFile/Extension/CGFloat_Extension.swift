
import Foundation
import UIKit
public extension CGFloat {
   
    func pixelsToPoints() -> CGFloat {
        return self / UIScreen.main.scale
    }
   
    static func onePixelInPoints() -> CGFloat {
        return CGFloat(1).pixelsToPoints()
    }
}
