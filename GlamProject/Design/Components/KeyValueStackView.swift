
import SnapKit
import RxSwift
import RxCocoa
import RxRelay
import RxGesture

class KeyValueStackView: UIStackView {


    
    var keyLabel = BasePaddingLabel(padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)).then{
        $0.textAlignment = .left
        $0.textColor = .black
        $0.font =  UIFont.systemFont(ofSize: 16, weight: .regular)
    }
    
    
    
    var valueLabel = UILabel().then{
        $0.textAlignment = .left
        $0.textColor = .glamBlue
        $0.setContentHuggingPriority(UILayoutPriority(251), for: .horizontal)
        $0.font =  UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.isHidden = false
    }
    
    var lockIcon = UIImageView().then{
        $0.image = UIImage(named: "lock")
        $0.contentMode = .left
        $0.image?.imageWithInsets(insets: UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 0))
        $0.setContentHuggingPriority(UILayoutPriority(249), for: .horizontal)
        $0.isHidden = true
 
    }

    var valueTextField = DoneTextField().then{
        $0.textAlignment = .left
        $0.textColor = .glamBlue
        $0.font =  UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.isHidden = true
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
   }
    
    
    
    func uiSetting(edit : Bool = false , lockIconHidden : Bool = true , key : String , placeHolder : String = "입력해주세요") {
        self.axis = .horizontal
        self.distribution = .fill
        self.alignment = .center
        
        self.addArrangedSubview(keyLabel)
        self.addArrangedSubview(valueLabel)
        self.addArrangedSubview(lockIcon)
        self.addArrangedSubview(valueTextField)
        
        self.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(44)
        }
     
        keyLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.35)
        }
        
        keyLabel.text = key
        
        if(edit){
            valueTextField.placeholder = placeHolder
            valueTextField.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray4.cgColor])

        }
        
      
        
        valueLabel.isHidden = edit
        lockIcon.isHidden = lockIconHidden
        valueTextField.isHidden = !edit
        
        
        
    }
}
