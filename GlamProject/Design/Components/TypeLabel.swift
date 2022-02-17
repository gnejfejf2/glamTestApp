//
//  TypeLabel.swift
//  GlamTestApp
//
//  Created by Hwik on 2022/02/17.
//

import UIKit
import SnapKit
import RxSwift


protocol TypeLabelDelegate : AnyObject {
    func typeChange(type : MetaDataType , name : String)
}

class TypeLabel: UILabel {
    var type : MetaDataType?
    var name : String?
    private let disposeBag = DisposeBag()
    weak var delegate : TypeLabelDelegate?
    
    override init(frame: CGRect ) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
   }
    
    
    init(type : MetaDataType? = nil , name : String? = nil){
        super.init(frame: .zero)
        
        self.name = name
        self.type = type
        uiSetting()
    }
    
    
    func uiSetting(){
        text = name
        textAlignment = .left
        self.snp.makeConstraints { make in
            make.height.equalTo(44)
        }
        
        self.rx.tapGesture(configuration: .none)
            .when(.recognized)
            .asDriver { _ in .never() }
            .drive(onNext: { [weak self] _ in
                guard let type = self?.type , let name = self?.name else { return }
                self?.delegate?.typeChange(type : type , name : name)
            })
            .disposed(by: disposeBag)
    }
}
