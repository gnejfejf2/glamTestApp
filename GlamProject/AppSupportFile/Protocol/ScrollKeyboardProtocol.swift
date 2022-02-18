import Foundation
import UIKit

protocol ScrollKeyboardProtocl {
    
    
    func notificationCenterRegister()
    func notificationCenterDelete()
 
    
    func keyboardWillShow(_ notification : NSNotification)
    func keyboardWillHide(_ notification: NSNotification)
}



