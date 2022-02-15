//
//  CellSettingProtocol.swift
//  GramTestApp
//
//  Created by Hwik on 2022/02/15.
//

import Foundation
import UIKit

protocol CellCettingProtocol {
    func addSubviews()
    func configure()
}




class CellSuperClass : UICollectionViewCell , CellCettingProtocol{
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubviews()
        configure()
    }

   

 
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func addSubviews() {
    
    }

    func configure() {
      
    }
}
