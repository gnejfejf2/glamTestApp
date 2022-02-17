import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa
import RxRelay
import RxGesture
import Kingfisher


class CustomIntroductionCollectionViewCell : CellSuperClass {
    static var id: String { NSStringFromClass(Self.self).components(separatedBy: ".").last ?? "" }
    
    lazy var mainStackView = UIStackView().then{
        $0.axis = .vertical
        $0.spacing = 8
        $0.alignment = .leading
        $0.distribution = .fill
        
        $0.addArrangedSubview(customPickLabel)
        $0.addArrangedSubview(gramPickStackView)
        $0.addArrangedSubview(topPickStackView)
        $0.addArrangedSubview(bodyStackView)
        $0.addArrangedSubview(petStackView)
      
    }
    
    var customPickLabel = UILabel().then{
        $0.text = "맞춤 추천"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        $0.textColor = .black
       
        $0.layer.masksToBounds = true
      
    }
    
    var gramPickStackView = CustomPickStackView().then{
        $0.uiSetting(item: .glam)
    }
    var topPickStackView = CustomPickStackView().then{
        $0.uiSetting(item: .top)
    }
    var bodyStackView = CustomPickStackView().then{
        $0.uiSetting(item: .body)
    }
    var petStackView = CustomPickStackView().then{
        $0.uiSetting(item: .pet)
    }
   
    
    
    
    var likeButton = UIButton().then{
        $0.setTitle("좋아요", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        $0.backgroundColor = .glamBlue
        $0.layer.cornerRadius = 8
    }
    
    var item : Introduction?
    var viewModel : HomeViewModel?
    var bag = DisposeBag()
    
    func uiSetting(){
        addSubviews()
        
        
        
        layoutIfNeeded()
    }
    
    override func addSubviews() {
        addSubview(mainStackView)
      
    }
    
    override func configure() {
        mainStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        gramPickStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
        topPickStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
        bodyStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(62)
        }
        petStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(62)
        }
        
        gramPickStackView.selectButton.rx.tap
            .asDriver { _ in .never() }
            .drive{ [weak self] tapEvent in
                guard let viewModel = self?.viewModel else { return }
                viewModel.input.customAdd.onNext(tapEvent)
            }
            .disposed(by: bag)
        
    }
    
    
}
