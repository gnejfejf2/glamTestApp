
import UIKit
import SnapKit
import Then

class PopUpView: UIView {

    let buttonHeight : CGFloat = 44
    
    lazy var backgroundView = UIView().then {
        $0.backgroundColor = .black.withAlphaComponent(0.3)
        $0.addSubview(mainStackView)
    }
   
   
    
    
    lazy var mainStackView = UIStackView().then {
        $0.backgroundColor = .white
        $0.axis = .vertical
        $0.spacing = 0
        $0.distribution = .fill
        $0.alignment = .center
        $0.layer.cornerRadius = 8
        $0.addArrangedSubview(titleLabel)
        $0.addArrangedSubview(devideLineView)
        $0.addArrangedSubview(contentScrollView)
    }
    
    lazy var contentScrollView = UIScrollView().then{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.showsVerticalScrollIndicator = false
        $0.layer.cornerRadius = 8
        $0.addSubview(contentStackView)
    }
    
    lazy var contentStackView = UIStackView().then {
        $0.backgroundColor = .white
        $0.axis = .vertical
        $0.spacing = 0
        $0.alignment = .center
        $0.distribution = .fill
        $0.layer.cornerRadius = 8
  
    }
    
    
    let titleLabel = UILabel().then {
        $0.text = "123123"
        $0.font =  UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
      
    }
  
    let devideLineView = DevideLineView()
  
 
    
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        uiSetting()
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        uiSetting()
       
    }
    
  
    
    func uiSetting(){
        self.addSubview(backgroundView)
        self.addSubview(mainStackView)
        
        
        backgroundView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        mainStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.center.equalToSuperview()
            make.height.lessThanOrEqualTo(412)
        }
        
        devideLineView.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        contentScrollView.snp.makeConstraints { make in
            make.top.equalTo(devideLineView.snp.bottom)
            make.leading.bottom.trailing.equalToSuperview()
        }
        
        contentStackView.snp.makeConstraints { make in
            make.edges.equalTo(contentScrollView)
            make.width.equalTo(contentScrollView).priority(1000)
            make.height.equalTo(contentScrollView).priority(250)
        }
    }
 
    
}
