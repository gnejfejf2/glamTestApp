//
//  CGFloat_Extension.swift
//  GramTestApp
//
//  Created by Hwik on 2022/02/15.
//

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
