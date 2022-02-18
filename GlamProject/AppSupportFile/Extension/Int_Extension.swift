
import Foundation
import UIKit

public extension Int {

    func getKmMToString() -> String{
        
        if self >= 1000 {
            return "\(ceil(Double(self) / 1000.0 * 10.0) / 10)km"
        } else {
            return "\(self)m"
        }
        
    }
    
    func getCm() -> String{
        
        return String(self) + "cm"
    }
    
}
