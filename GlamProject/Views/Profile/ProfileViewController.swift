//
//  ProfileViewController.swift
//  GlamTestApp
//
//  Created by Hwik on 2022/02/16.
//

import SnapKit
import RxSwift
import RxCocoa
import RxDataSources
import RxRelay
import RxGesture

class ProfileViewController: SuperViewControllerSetting {
    
    
     var viewModel : ProfileViewModel?
  
    lazy var mainScrollView = UIScrollView().then{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 0)
        
        $0.addSubview(contentView)
     
    }
    
    lazy var contentView = UIView().then {
        $0.addSubview(topImageCollectionView)
        $0.addSubview(imageMoreView)
        $0.addSubview(informationStackView)
    }
    
    
    lazy var topImageCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.scrollDirection = .vertical
        
        layout.itemSize = CGSize(width: cellWidthHeight , height: cellWidthHeight)
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.indicatorStyle = .white
        collectionView.isScrollEnabled = false
        collectionView.register(ImageCellCollectionViewCell.self, forCellWithReuseIdentifier: ImageCellCollectionViewCell.id)
        return collectionView
    }()
   
    lazy var imageMoreView = UIStackView().then{
        $0.axis = .vertical
        $0.spacing = 4
        $0.distribution = .equalSpacing
        $0.alignment = .center
       
        $0.addArrangedSubview(devideLineView1)
        $0.addArrangedSubview(imageTextView)
        $0.addArrangedSubview(devideLineView2)
    }
    
    
    
    var devideLineView1 = DevideLineView()
    
    lazy var imageTextView = UIStackView().then{
        $0.axis = .horizontal
        $0.spacing = 4
        $0.distribution = .equalSpacing
        $0.alignment = .center
        $0.addArrangedSubview(morePhotoLabel)
        $0.addArrangedSubview(moreInformationLabel)
     
    }
    
    var morePhotoLabel = UILabel().then{
        $0.text = "다양한 매력을 보여줄 수 있는 사진을 올려주세요"
        $0.textColor = .gray1
        $0.textAlignment = .right
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
    }
    
    var moreInformationLabel = UILabel().then{
        $0.text = "더 알아보기"
        $0.textColor = .gray4
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
    }
    
    var devideLineView2 = DevideLineView()
    
    lazy var informationStackView = UIStackView().then{
        $0.axis = .vertical
        $0.spacing = 8
        $0.distribution = .fill
        $0.alignment = .center
        $0.addArrangedSubview(nickNameStack)
        $0.addArrangedSubview(genderStack)
        $0.addArrangedSubview(birthdayStack)
        $0.addArrangedSubview(locationStack)
        $0.addArrangedSubview(devideLineView3)
        $0.addArrangedSubview(introductionStack)
        $0.addArrangedSubview(introductionTextField)
        $0.addArrangedSubview(warningLabel)
        $0.addArrangedSubview(devideLineView4)
        $0.addArrangedSubview(heightStack)
        $0.addArrangedSubview(bodyTypeStack)
        $0.addArrangedSubview(devideLineView5)
        $0.addArrangedSubview(companyStack)
        $0.addArrangedSubview(jobStack)
        $0.addArrangedSubview(educationStack)
        $0.addArrangedSubview(schoolStack)

    }
    
    
    var nickNameStack = KeyValueStackView().then{
        $0.uiSetting(lockIconHidden : false ,  key: "닉네임")
       
    }
    var genderStack = KeyValueStackView().then{
        $0.uiSetting(key: "성별")
        $0.valueLabel.textColor = .black
      
    }
    var birthdayStack = KeyValueStackView().then{
        $0.uiSetting(key: "생일")
    }
    
    var locationStack = KeyValueStackView().then{
        $0.uiSetting(key: "위치")
    }
    
    var devideLineView3 = DevideLineView()
    
    var introductionStack = KeyValueStackView().then{
        $0.uiSetting(key: "소개")
        $0.snp.remakeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(35)
        }
    }
    
    var introductionTextField = DoneTextField().then{
        $0.placeholder = "회원님의 매력을 간단하게 소개해주세요"
        $0.font =  UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .black
        $0.textAlignment = .left
    }
    
    var warningLabel = UILabel().then {
        $0.text = "SNS 아이디 등 연락처 입력 시 서비스 이용 제한됩니다"
        $0.font =  UIFont.systemFont(ofSize: 12, weight: .regular)
        $0.textColor = .gray4
    }
   
    var devideLineView4 = DevideLineView()

    var heightStack = KeyValueStackView().then{
        $0.uiSetting(key: "키")
    }
    
    var bodyTypeStack = KeyValueStackView().then{
        $0.uiSetting(key: "체형")
    }
    
    var devideLineView5 = DevideLineView()

    var companyStack = KeyValueStackView().then{
        $0.uiSetting(edit: true , key: "직장")
    }
    var jobStack = KeyValueStackView().then{
        $0.uiSetting(edit: true , key: "직업")
    }
    
    var educationStack = KeyValueStackView().then{
        $0.uiSetting(key: "학력")
    }
    
    var schoolStack = KeyValueStackView().then{
        $0.uiSetting(edit: true , key: "학력")
    }
   
    var cellWidthHeight = (UIScreen.main.bounds.width - 2) / 3
    
    var openPopUp : PopUpView?
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationBarSetting(hidden: false)
        navigationBarTitleSetting("프로필 수정")
        notificationCenterRegister()
        tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        notificationCenterDelete()
    }

    
    override func uiDrawing() {
        super.uiDrawing()
        view.addSubview(mainScrollView)
    }
    
    override func uiSetting() {
        mainScrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(mainScrollView)
            make.width.equalTo(mainScrollView).priority(1000)
            make.height.equalTo(mainScrollView).priority(250)
        }
        
        guard let layout = topImageCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        topImageCollectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(mainScrollView)
            make.height.equalTo(cellWidthHeight * 2 + layout.minimumLineSpacing)
        }
        
        imageMoreView.snp.makeConstraints { make in
            make.top.equalTo(topImageCollectionView.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
        }
        
        informationStackView.snp.makeConstraints { make in
            make.top.equalTo(imageMoreView.snp.bottom)
    
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }

        introductionTextField.snp.remakeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        warningLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
       
        
    }

    override func uiBinding() {
        viewModel?.output.imageModels
            .map{ [weak self] in  self?.dommyStringAdd(items: $0) ?? [String]() }
            .asDriver { _ in .never() }
            .drive(topImageCollectionView.rx.items(cellIdentifier: ImageCellCollectionViewCell.id, cellType: ImageCellCollectionViewCell.self)){ [weak self] (index , element , cell) in
             
            }
            .disposed(by: disposeBag)
        
        viewModel?.output.userProfile
            .map{ $0.name }
            .asDriver { _ in .never() }
            .drive(nickNameStack.valueLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel?.output.userProfile
            .map{ $0.gender.rawValue }
            .asDriver { _ in .never() }
            .drive(genderStack.valueLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel?.output.userProfile
            .map{ $0.birthday }
            .asDriver { _ in .never() }
            .drive(birthdayStack.valueLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel?.output.userProfile
            .map{ $0.location }
            .asDriver { _ in .never() }
            .drive(locationStack.valueLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel?.output.userProfile
            .map{ $0.introduction }
            .asDriver { _ in .never() }
            .drive(introductionTextField.rx.text)
            .disposed(by: disposeBag)
        
        
        viewModel?.output.userProfile
            .map{ $0.height?.getCm() }
            .asDriver { _ in .never() }
            .map({ text in
                if(text == "" || text == nil){
                    return "선택해주세요"
                }else{
                    return text!
                }
            })
            .drive(heightStack.valueLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel?.output.userProfile
            .map{ $0.height?.getCm() }
            .asDriver { _ in .never() }
            .map({ text in
                if(text == "" || text == nil){
                    return .gray4
                }else{
                    return .glamBlue
                }
            })
            .drive(heightStack.valueLabel.rx.textColor)
            .disposed(by: disposeBag)
        
        
        viewModel?.output.userProfile
            .map{ $0.bodyType?.rawValue }
            .asDriver { _ in .never() }
            .map({ text in
                if(text == "" || text == nil){
                    return "선택해주세요"
                }else{
                    return text!
                }
            })
            .drive(bodyTypeStack.valueLabel.rx.text)
            .disposed(by: disposeBag)
        
        
        viewModel?.output.userProfile
            .map{ $0.bodyType?.rawValue }
            .asDriver { _ in .never() }
            .map({ text in
                if(text == "" || text == nil){
                    return .gray4
                }else{
                    return .glamBlue
                }
            })
            .drive(bodyTypeStack.valueLabel.rx.textColor)
            .disposed(by: disposeBag)
        
        
        viewModel?.output.userProfile
            .map{ $0.education?.rawValue }
            .asDriver { _ in .never() }
            .map({ text in
                if(text == "" || text == nil){
                    return "선택해주세요"
                }else{
                    return text!
                }
            })
            .drive(educationStack.valueLabel.rx.text)
            .disposed(by: disposeBag)
        
        
        viewModel?.output.userProfile
            .map{ $0.education?.rawValue }
            .asDriver { _ in .never() }
            .map({ text in
                if(text == "" || text == nil){
                    return .gray4
                }else{
                    return .glamBlue
                }
            })
            .drive(educationStack.valueLabel.rx.textColor)
            .disposed(by: disposeBag)
        
        
    }
    
    override func eventBinding() {
        bodyTypeStack.rx.tapGesture(configuration: .none)
            .when(.recognized)
            .asDriver { _ in .never() }
            .drive(onNext: { [weak self] _ in
                self?.openPopUp(type: .bodyTypes, data: self?.viewModel?.output.metaData.value?.bodyTypes ?? [])
            }).disposed(by: disposeBag)
        
        educationStack.rx.tapGesture(configuration: .none)
            .when(.recognized)
            .asDriver { _ in .never() }
            .drive(onNext: { [weak self] _ in
                self?.openPopUp(type: .educations, data: self?.viewModel?.output.metaData.value?.educations ?? [])
            }).disposed(by: disposeBag)
        
        introductionTextField.rx.text
            .compactMap{ $0 }
            .bind(onNext: { [weak self] item in
                self?.typeChange(type: .introduction, name: item )
            })
            .disposed(by: disposeBag)
        
        companyStack.valueTextField.rx.text
            .compactMap{ $0 }
            .bind(onNext: { [weak self] item in
                self?.typeChange(type: .company, name: item)
            })
            .disposed(by: disposeBag)
        
        jobStack.valueTextField.rx.text
            .compactMap{ $0 }
            .bind(onNext: { [weak self] item in
                self?.typeChange(type: .job, name: item)
            })
            .disposed(by: disposeBag)
        
        schoolStack.valueTextField.rx.text
            .compactMap{ $0 }
            .bind(onNext: { [weak self] item in
                self?.typeChange(type: .school, name: item)
            })
            .disposed(by: disposeBag)
        
    }
    
    func dommyStringAdd(items : [String]) -> [String]{
        var strings = items
        for _ in items.count..<6 {
            strings.append("")
        }
        return strings
    }
 
    func openPopUp(type : MetaDataType , data : [MetaValue]){
        let popup = PopUpView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
       
        popup.titleLabel.text = type.rawValue
        openPopUp = popup
        for item in data {
            let contentLabel = TypeLabel(type: type, name: item.name)
            contentLabel.delegate = self
            
            popup.contentStackView.addArrangedSubview(contentLabel)
            contentLabel.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(16)
                make.trailing.equalToSuperview().offset(-16)
            }
        }
        view.addSubview(popup)
    }
    
}

extension ProfileViewController {
    func notificationCenterRegister(){
        NotificationCenter.default.addObserver(self,selector: #selector(keyboardWillShow),name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self,selector: #selector(keyboardWillHide),name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    func notificationCenterDelete(){
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillShowNotification)
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillHideNotification)
    }
    @objc func keyboardWillShow(_ notification : NSNotification){

        guard let keyboardFrame = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
            
        mainScrollView.contentInset.bottom = view.convert(keyboardFrame.cgRectValue, from: nil).size.height

    }
    @objc func keyboardWillHide(_ notification: NSNotification){
        mainScrollView.contentInset.bottom = 0
    }
}

extension ProfileViewController : TypeLabelDelegate {
    
    func typeChange(type : MetaDataType , name : String) {
        openPopUp?.removeFromSuperview()
        viewModel?.input.changeValue.onNext((type , name))
    }
    
}
