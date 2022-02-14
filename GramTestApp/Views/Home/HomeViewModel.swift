//
//  HomeViewModel.swift
//  GramTestApp
//
//  Created by Hwik on 2022/02/14.
//

import Foundation
protocol HomeViewModelProtocol {
    var coordinator : HomeViewCoordinator { get }
 
}


class HomeViewModel : ViewModelProtocol , HomeViewModelProtocol{
    
    var coordinator : HomeViewCoordinator
    
    init(coordinator : HomeViewCoordinator){
        self.coordinator = coordinator
    }
    
    
    func inputBinding() {
        
    }
    
    func outputBinding() {
        
    }
    
    
    
    
}
