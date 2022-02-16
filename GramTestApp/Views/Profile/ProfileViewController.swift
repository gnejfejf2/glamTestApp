//
//  ProfileViewController.swift
//  GlamTestApp
//
//  Created by Hwik on 2022/02/16.
//

import Foundation
import UIKit

class ProfileViewController: SuperViewControllerSetting {
    
    
     var viewModel : ProfileViewModel?
  
    lazy var mainScrollView = UIScrollView().then{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 0)
        
        $0.addSubview(topImageCollectionView)
     
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
   
    
    var cellWidthHeight = (UIScreen.main.bounds.width - 2) / 3
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationBarSetting(hidden: false)
        navigationBarTitleSetting("프로필 수정")
        tabBarController?.tabBar.isHidden = true
    }


    
    override func uiDrawing() {
        super.uiDrawing()
        view.addSubview(topImageCollectionView)
    }
    
    override func uiSetting() {
        guard let layout = topImageCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        
        mainScrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        
        topImageCollectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(cellWidthHeight * 2 + layout.minimumLineSpacing)
        }
    }

    override func uiBinding() {
        viewModel?.output.imageModels
            .map{ [weak self] in  self?.dommyStringAdd(items: $0) ?? [String]() }
            .bind(to : topImageCollectionView.rx.items(cellIdentifier: ImageCellCollectionViewCell.id, cellType: ImageCellCollectionViewCell.self)){ [weak self] (index , element , cell) in
             
            }
            .disposed(by: disposeBag)
    }
    
    func dommyStringAdd(items : [String]) -> [String]{
        var strings = items
        for _ in items.count..<6 {
            strings.append("")
        }
        return strings
    }
    
    
}
