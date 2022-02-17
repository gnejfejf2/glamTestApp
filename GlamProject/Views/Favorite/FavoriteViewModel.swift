//
//  FavoriteViewModel.swift
//  GramTestApp
//
//  Created by Hwik on 2022/02/14.
//

import Foundation
protocol FavoriteViewModelProtocol {
    var coordinator : FavoriteViewCoordinator { get }
 
}


class FavoriteViewModel : ViewModelProtocol , FavoriteViewModelProtocol{
    
    var coordinator : FavoriteViewCoordinator
    
    init(coordinator : FavoriteViewCoordinator){
        self.coordinator = coordinator
    }
    
    
    func inputBinding() {
        
    }
    
    func outputBinding() {
        
    }
    
    
    
    
}
