//
//  ImageCellCollectionViewController.swift
//  GlamTestApp
//
//  Created by Hwik on 2022/02/16.
//

import UIKit
import Then
import Kingfisher
import SnapKit
private let reuseIdentifier = "Cell"

class ImageCellCollectionViewCell : CellSuperClass {
    static var id: String { NSStringFromClass(Self.self).components(separatedBy: ".").last ?? "" }
    
    lazy var mainImage = UIImageView().then{
        $0.image = UIImage(named: "은하")
        $0.contentMode = .scaleToFill
    }
    
    func uiSetting(fileURL : String = ""){
        if fileURL != "" {
            mainImage.kf.setImage(with : fileURL.getImageURL())
        }
        
       
    }
    
    override func addSubviews() {
        contentView.addSubview(mainImage)
   
    }

    override func configure() {
      
        mainImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
