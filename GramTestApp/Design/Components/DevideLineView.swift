//
//  DevideLineView.swift
//  GlamTestApp
//
//  Created by Hwik on 2022/02/16.
//

import UIKit

class DevideLineView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        uiSetting()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        uiSetting()
   }
    
    func uiSetting(){
        backgroundColor = .gray1
    }

}
