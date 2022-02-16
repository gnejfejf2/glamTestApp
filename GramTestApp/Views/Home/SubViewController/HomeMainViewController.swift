import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources
import RxRelay
import RxGesture

class HomeMainViewController : SuperViewControllerSetting {
    
    let daysScheduleCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.indicatorStyle = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = .fast
        collectionView.register(IntroductionCollectionViewCell.self, forCellWithReuseIdentifier: IntroductionCollectionViewCell.id)
        collectionView.register(CustomIntroductionCollectionViewCell.self, forCellWithReuseIdentifier: CustomIntroductionCollectionViewCell.id)
        return collectionView
    }()
    
    
    
    var homeTapBar : HomePageTapBar?
    
    var viewModel : HomeViewModel?
    
    

    override func uiDrawing() {
        view.backgroundColor = .primaryColorReverse
        view.addSubview(daysScheduleCollectionView)
        
        
        daysScheduleCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    override func uiSetting() {
        daysScheduleCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    override func uiBinding() {
        
        viewModel?.output.mainIntroductionModels
            .bind(to : daysScheduleCollectionView.rx.items){ [weak self]
                (collectionView , index , item) in
                if(item.cellType == .Customize){
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomIntroductionCollectionViewCell.id, for: IndexPath(index: index)) as! CustomIntroductionCollectionViewCell
                    cell.viewModel = self?.viewModel
                    
                    return cell
                }else{
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IntroductionCollectionViewCell.id, for: IndexPath(index: index)) as! IntroductionCollectionViewCell
                    
                    cell.item = item
                    cell.uiSetting()
                    cell.viewModel = self?.viewModel
                    return cell
                }
            }.disposed(by: disposeBag)
        
        
 
        
    }
    
    override func eventBinding() {
 
        daysScheduleCollectionView.rx.reachedBottom(offset: 0)
            .asDriver { _ in .never() }
            .drive(viewModel!.input.readAdd)
            .disposed(by: disposeBag)
    }
    
}

extension HomeMainViewController :  UIScrollViewDelegate , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - 16
        
        
        if(viewModel?.output.mainIntroductionModels.value[indexPath[1]].cellType == .Customize){
            
            let dummyHeight: CGFloat = 300
            let dummyCell = CustomIntroductionCollectionViewCell(
                frame: CGRect(x: 0, y: 0, width: width, height: dummyHeight))
            dummyCell.uiSetting()
            dummyCell.layoutIfNeeded()
            let estimatedSize = dummyCell.systemLayoutSizeFitting(CGSize(width: width, height: dummyHeight))
            return CGSize(width: width, height: estimatedSize.height)
            
        }else{
            return CGSize(width: width , height: (UIScreen.main.bounds.width - 16) * 1.4)
        }
        
        
        
    }
    
    //velocity 제스처의 방향 및 속도
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let layout = self.daysScheduleCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        let cellWidthIncludingSpacing : CGFloat = ((UIScreen.main.bounds.width - 16) * 1.4) + layout.minimumLineSpacing
        let estimatedIndex = scrollView.contentOffset.y / cellWidthIncludingSpacing
        let index: Int
        if velocity.y >  0 {
            index = Int(ceil(estimatedIndex))
        } else if velocity.y < 0 {
            index = Int(floor(estimatedIndex))
        } else {
            index = Int(round(estimatedIndex))
        }
        
        targetContentOffset.pointee = CGPoint(x: 0, y: (index * Int(cellWidthIncludingSpacing)) )
    }
}
