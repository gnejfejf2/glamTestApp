import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources
import RxRelay
import RxGesture
import Kingfisher


class IntroductionCollectionViewCell : CellSuperClass {
    static var id: String { NSStringFromClass(Self.self).components(separatedBy: ".").last ?? "" }
    
    
    
    
    
    var mainImageView = UIImageView().then{
        $0.image = UIImage(named: "은하")
        $0.contentMode = .scaleToFill
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 10
    }
    
  
    
    
    lazy var informationStackView = UIStackView().then{
        $0.axis = .vertical
        $0.spacing = 8
        $0.alignment = .leading
        $0.distribution = .fill
        $0.addArrangedSubview(todayPick)
        $0.addArrangedSubview(informationTopStackView)
        $0.addArrangedSubview(informationMiddleStackView)
        $0.addArrangedSubview(informationBottomStackView)
        
    }
  
    var todayPick = BasePaddingLabel().then{
        $0.text = "오늘의 추천"
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .white
        $0.backgroundColor = .white.withAlphaComponent(0.25)
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 8
    }
    
    lazy var informationTopStackView = UIStackView().then{
        $0.axis = .horizontal
        $0.spacing = 4
        $0.alignment = .center
        $0.distribution = .fill
        $0.isLayoutMarginsRelativeArrangement = true
        $0.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 4, leading: 0, bottom: 0, trailing:  0)
        $0.addArrangedSubview(nickNameAgeLabel)
        $0.addArrangedSubview(informationIconImageView)
    }
    
    var nickNameAgeLabel = UILabel().then{
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
    }
    
    var informationIconImageView = UIImageView().then{
        $0.image = UIImage(named: "info")
    }
    
    lazy var informationMiddleStackView = UIStackView().then{
        $0.axis = .vertical
        $0.spacing = 4
        $0.alignment = .leading
        $0.distribution = .fill
        
        $0.addArrangedSubview(introductionLabel)
        $0.addArrangedSubview(jobDistanceLabel)
        $0.addArrangedSubview(heightLabel)
    }
    
    var introductionLabel = UILabel().then{
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.numberOfLines = 2
    }
    
    var jobDistanceLabel = UILabel().then{
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    }
    
    var heightLabel = UILabel().then{
       $0.textColor = .white.withAlphaComponent(0.6)
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    }
    
    
    lazy var informationBottomStackView = UIStackView().then{
        $0.axis = .horizontal
        $0.spacing = 8
//        $0.alignment = .center
        $0.distribution = .fill
        
        $0.addArrangedSubview(cancelButton)
        $0.addArrangedSubview(likeButton)
        
        $0.snp.makeConstraints { make in
            make.height.equalTo(44)
        }
    }
    
    var cancelButton = UIButton().then{
        $0.setImage(UIImage(named: "delete"), for: .normal)
        $0.backgroundColor = .darkGray1
        $0.layer.cornerRadius = 8
        $0.snp.makeConstraints { make in
            make.width.equalTo(48)
        }
    }
    
    var likeButton = UIButton().then{
        $0.setTitle("좋아요", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        $0.backgroundColor = .glamBlue
        $0.layer.cornerRadius = 8
    }
    
    var item : MainIntroductionModel?
    var viewModel : HomeViewModel?
    var bag = DisposeBag()
    
    
    func uiSetting(){
        
        if(item?.cellType == .TodayPick){
            todayPick.isHidden = false
        }else{
            todayPick.isHidden = true
        }
     
        guard let itemData = item?.data else { return }
        nickNameAgeLabel.text = "\(itemData.name), \(itemData.age)"
        
        if(itemData.introduction == nil){
            introductionLabel.isHidden = true
            jobDistanceLabel.isHidden = false
            heightLabel.isHidden = false
            jobDistanceLabel.text = itemData.jobDistanceText()
            heightLabel.text = itemData.heightText()
        }else{
            introductionLabel.isHidden = false
            jobDistanceLabel.isHidden = true
            heightLabel.isHidden = true
            introductionLabel.text = itemData.introduction!
        }
        
        if itemData.pictures?.count ?? 0 > 0 {
            mainImageView.kf.setImage(with: itemData.pictures?[0].getImageURL())
        }

     }
    
    override func addSubviews() {
        contentView.addSubview(mainImageView)
        contentView.addSubview(informationStackView)
//        contentview.addSubview(mainImageView)
//        addSubview(informationStackView)
        
    }
    
    override func configure() {
        
        mainImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        informationStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        informationBottomStackView.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalToSuperview()
        }
        
        cancelButton.rx.tap
            .asDriver { _ in .never() }
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                guard let data = self.item else { return }

                self.viewModel?.input.removeAction.onNext(data)
            }).disposed(by: bag)
        
    }
    
 
}
