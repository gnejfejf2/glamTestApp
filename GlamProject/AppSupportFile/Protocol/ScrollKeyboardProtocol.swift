//
//  ScrollKeyboardProtocol.swift
//  GlamProject
//
//  Created by Hwik on 2022/02/17.
//

import Foundation

protocol ScrollKeyboardProtocl {
    func notificationCenterRegister()
    func notificationCenterDelete()
    func keyboardWillShow(_ notification : NSNotification)
    func keyboardWillHide(_ notification: NSNotification)
}
