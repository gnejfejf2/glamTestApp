//
//  CustomPickStackView.swift
//  GlamTestApp
//
//  Created by Hwik on 2022/02/15.
//

import UIKit
import Then
import SnapKit

class CustomPickStackView: UIStackView {

    lazy var leftStackvView = UIStackView().then{
        $0.axis = .horizontal
        $0.spacing = 4
        $0.distribution = .fill
        $0.alignment = .center
        
        $0.addArrangedSubview(iconImageView)
        $0.addArrangedSubview(titleLabel)
        $0.addArrangedSubview(hotIcon)
        
    }
    
    var iconImageView = UIImageView().then{
        $0.image = UIImage(named: "dia")
        $0.contentMode = .scaleAspectFit
        $0.largeContentImageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
    }
    
    
    var titleLabel = UILabel().then{
        $0.text = "강지윤"
        $0.textAlignment = .left
        $0.textColor = .black
    }
    
    var hotIcon = UIImageView().then{
        $0.image = UIImage(named: "hot")
        $0.contentMode = .scaleAspectFit
    }

    
    var selectButton = UIButton().then{
        $0.setTitle("선택", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        $0.backgroundColor = .glamBlue
        $0.contentMode = .center
        $0.layer.cornerRadius = 8
    }
    
    
    var custompPickItem : CustopPickModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
   }
    
    
    
    func uiSetting(item : CustomPickItem) {
        self.axis = .horizontal
        self.spacing = 4
        self.distribution = .equalSpacing
        self.alignment = .center
       
        self.addArrangedSubview(leftStackvView)
        self.addArrangedSubview(selectButton)
        
        custompPickItem = item.returnModel()
        
        guard let custompPickItem = custompPickItem else { return }

        
        iconImageView.image = UIImage(named: custompPickItem.iconName)
        titleLabel.text = custompPickItem.name
        hotIcon.isHidden = !custompPickItem.hot
        
        selectButton.snp.makeConstraints { make in
            make.width.equalTo(76)
            make.height.equalTo(32)
        }
       
        
    }
    
  

}
