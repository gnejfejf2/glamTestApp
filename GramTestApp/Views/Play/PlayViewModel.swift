
import Foundation
protocol PlayViewModelProtocol {
    var coordinator : PlayViewCoordinator { get }
 
}


class PlayViewModel : ViewModelProtocol , PlayViewModelProtocol{
    
    var coordinator : PlayViewCoordinator
    
    init(coordinator : PlayViewCoordinator){
        self.coordinator = coordinator
    }
    
    
    func inputBinding() {
        
    }
    
    func outputBinding() {
        
    }
    
    
    
    
}
