
import UIKit
import Then
import SnapKit
import RxSwift

class MyCollectionViewCell : CellSuperClass{

    static var id: String { NSStringFromClass(Self.self).components(separatedBy: ".").last ?? "" }
    
    

  
    lazy var mainStackView = UIStackView().then{
        $0.axis = .vertical
        $0.spacing = 12
        $0.alignment = .center
        $0.distribution = .fill
       

        $0.addArrangedSubview(logoImage)
        $0.addArrangedSubview(titleLabel)
        $0.addArrangedSubview(underLineView)
    }

    lazy var logoImage = UIImageView().then{
        $0.image = UIImage(named: "logo")?.withRenderingMode(.alwaysTemplate)
        $0.tintColor = .black
        $0.contentMode = .scaleToFill
        $0.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
    }
    
    lazy var titleLabel = UILabel().then{
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        $0.textColor = .gray2
        $0.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
    }
    lazy var underLineView = UIView().then {
        
        $0.snp.makeConstraints { make in
            make.height.equalTo(2)
        }
        
    }
    
    override var isSelected: Bool {
        didSet {
            underLineView.backgroundColor = isSelected ? .black : .white
            titleLabel.textColor = isSelected ? .black : .gray2
            logoImage.tintColor = isSelected ? .black : .gray2
        }
    }

   
    
    var bag = DisposeBag()
    

   

 

    func uiSetting(cellType : HomePageTapBar){
        if(cellType == .Main){
            titleLabel.isHidden = true
        }else{
            logoImage.isHidden = true
            titleLabel.text = cellType.rawValue
        }
    }
    
    
    override func addSubviews() {
        addSubview(mainStackView)
   
    }

    override func configure() {
      
        mainStackView.snp.makeConstraints { make in

            make.leading.trailing.equalToSuperview()
            make.width.equalTo(titleLabel)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
        underLineView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
    }

   
}
