//
//  Int_Extension.swift
//  GramTestApp
//
//  Created by Hwik on 2022/02/15.
//

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
}
