//
//  MyViewModel.swift
//  GramTestApp
//
//  Created by Hwik on 2022/02/14.
//

import Foundation

protocol MyViewModelProtocol {
    var coordinator : MyViewCoordinator { get }
 
}


class MyViewModel : ViewModelProtocol , MyViewModelProtocol{
    
    var coordinator : MyViewCoordinator
    
    init(coordinator : MyViewCoordinator){
        self.coordinator = coordinator
    }
    
    
    func inputBinding() {
        
    }
    
    func outputBinding() {
        
    }
    
    
    
    
}
