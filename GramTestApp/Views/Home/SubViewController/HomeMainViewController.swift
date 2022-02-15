import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources
import RxRelay
import RxGesture

class HomeMainViewController: UIViewController , ViewSettingProtocol {
    
    let daysScheduleCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 16, height: (UIScreen.main.bounds.width - 16) * 1.4)
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        
        collectionView.indicatorStyle = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        //        collectionView.isPagingEnabled = true
        collectionView.register(IntroductionCollectionViewCell.self, forCellWithReuseIdentifier: IntroductionCollectionViewCell.id)
        
        return collectionView
    }()
    
    
    var dommyLabel = UILabel().then{
        $0.text = "123123123"
    }
    
    
    var homeTapBar : HomePageTapBar?
    
    var viewModel : HomeViewModel?
    
    
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiDrawing()
        uiSetting()
        uiBinding()
        eventBinding()
        
        
    }
    
    func uiDrawing() {
        view.backgroundColor = .primaryColorReverse
        view.addSubview(daysScheduleCollectionView)
        
        
        daysScheduleCollectionView.snp.makeConstraints { make in
            
            make.edges.equalTo(view.safeAreaLayoutGuide)
            
        }
        
    }
    
    func uiSetting() {
        daysScheduleCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    func uiBinding() {
        viewModel?.output.daySchedules
            .bind(to: daysScheduleCollectionView.rx.items(cellIdentifier: IntroductionCollectionViewCell.id, cellType: IntroductionCollectionViewCell.self)) {
                (row, element, cell) in
                
                cell.item = element?.data
                cell.uiSetting()
                //                cell.uiSetting(element.name)
            }.disposed(by: disposeBag)
    }
    
    func eventBinding() {
        
    }
    
    
    
    
}

extension HomeMainViewController :  UIScrollViewDelegate{
    
    
    //velocity 제스처의 방향 및 속도
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        
        
        guard let layout = self.daysScheduleCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        let cellWidthIncludingSpacing : CGFloat = layout.itemSize.height + layout.minimumLineSpacing
        let estimatedIndex = scrollView.contentOffset.y / cellWidthIncludingSpacing
        let index: Int
        if velocity.y >  0 {
            index = Int(ceil(estimatedIndex))
        } else if velocity.y < 0 {
            index = Int(floor(estimatedIndex))
        } else {
            index = Int(round(estimatedIndex))
        }
        //        print("cellWidthIncludingSpacing : \(cellWidthIncludingSpacing)")
        //        print("scrollView.contentOffset.y : \(scrollView.contentOffset.y)")
        //        print("velocity.y : \(velocity.y)")
        //        print("estimatedIndex : \(estimatedIndex)")
        targetContentOffset.pointee = CGPoint(x: 0, y: (index * Int(cellWidthIncludingSpacing)) )
    }
}
