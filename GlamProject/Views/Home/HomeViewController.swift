import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa
import RxRelay
import RxGesture


protocol HomeViewProrocol {
    func getPageViewControllers() -> [UIViewController]
}


class HomeViewController: SuperViewControllerSetting , HomeViewProrocol {
    
    
    
    lazy var collectionView : UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 8
        flowLayout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.backgroundColor = .white
        view.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: MyCollectionViewCell.id)
        return view
    }()
    
    var settingButton = UIButton().then{
        $0.setImage(UIImage(named: "setting"), for: .normal)
    }
    
    lazy var pageViewController: UIPageViewController = {
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        return vc
    }()
    
    
    var dataSource: [HomePageTapBar] = [.Main , .Closely , .Live]
    var dataSourceVC: [UIViewController] = []
    
    var viewModel : HomeViewModel?
    
    var currentPage: Int = 0 {
        didSet {
            bind(oldValue: oldValue, newValue: currentPage)
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationBarSetting(hidden: true)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func uiDrawing() {
        super.uiDrawing()
        view.addSubview(collectionView)
        view.addSubview(settingButton)
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        
    }
    
    override func uiSetting() {
        collectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        collectionView.rx.setDataSource(self)
            .disposed(by: disposeBag)
        
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalTo(settingButton.snp.leading)
            make.height.equalTo(44)
        }
        settingButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.trailing.equalToSuperview().offset(-12)
        }
        
        
        pageViewController.view.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(12)
            make.leading.trailing.bottom.equalToSuperview()
        }
        pageViewControllerSetting()
        pageViewController.didMove(toParent: self)
        
        if let firstVC = dataSourceVC.first {
            pageViewController.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        
        
        
    }
    
    
    
    
    override func eventBinding() {
        settingButton.rx.tap
            .asDriver { _ in .never() }
            .drive{ [weak self] tapEvent in
                guard let viewModel = self?.viewModel else { return }
                viewModel.input.moveSettingView.onNext(tapEvent)
            }
            .disposed(by: disposeBag)
    }
    
    
   
    
    func getPageViewControllers() -> [UIViewController]{
        var views : [UIViewController] = []
        //뷰컨 넣기
        dataSource.forEach { item in
            if(item == .Main){
                let vc = HomeMainViewController()
                vc.viewModel = viewModel
                views += [vc]
            }else{
                let vc = UIViewController()
                let red = CGFloat(arc4random_uniform(256)) / 255
                let green = CGFloat(arc4random_uniform(256)) / 255
                let blue = CGFloat(arc4random_uniform(256)) / 255
                
                vc.view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
                
                let label = UILabel()
                label.text = "123123"
                label.font = .systemFont(ofSize: 56, weight: .bold)
                
                vc.view.addSubview(label)
                label.snp.makeConstraints { make in
                    make.center.equalToSuperview()
                }
                views += [vc]
            }
            
        }
        return views
    }
    
    
    
}

extension HomeViewController {
    private func pageViewControllerSetting(){
        dataSourceVC = getPageViewControllers()
        currentPage = 0
    }
    
    private func bind(oldValue: Int, newValue: Int) {
        // collectionView 에서 선택한 경우
        let direction: UIPageViewController.NavigationDirection = oldValue < newValue ? .forward : .reverse
        pageViewController.setViewControllers([dataSourceVC[currentPage]], direction: direction, animated: true, completion: nil)
        // pageViewController에서 paging한 경우
        collectionView.selectItem(at: IndexPath(item: currentPage, section: 0), animated: true, scrollPosition: .centeredHorizontally)
    }
    
    private func didTapCell(at indexPath: IndexPath) {
        currentPage = indexPath.item
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.id, for: indexPath)
        if let cell = cell as? MyCollectionViewCell {
            cell.uiSetting(cellType: dataSource[indexPath[1]])
            
            cell.mainStackView.rx.tapGesture(configuration: .none)
                .when(.recognized)
                .asDriver { _ in .never() }
                .drive(onNext: { [weak self] _ in
                    self?.didTapCell(at: indexPath)
                }).disposed(by: cell.bag)
            
        }
        return cell
    }
}


extension HomeViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = dataSourceVC.firstIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        if previousIndex < 0 {
            return nil
        }
        return dataSourceVC[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = dataSourceVC.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        if nextIndex == dataSourceVC.count {
            return nil
        }
        return dataSourceVC[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let currentVC = pageViewController.viewControllers?.first,
              let currentIndex = dataSourceVC.firstIndex(of: currentVC) else { return }
        currentPage = currentIndex
    }
    
    
}
