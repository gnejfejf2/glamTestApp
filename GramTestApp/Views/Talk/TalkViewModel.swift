
import Foundation
protocol TalkViewModelProtocol {
    var coordinator : TalkViewCoordinator { get }
 
}


class TalkViewModel : ViewModelProtocol , TalkViewModelProtocol{
    
    var coordinator : TalkViewCoordinator
    
    init(coordinator : TalkViewCoordinator){
        self.coordinator = coordinator
    }
    
    
    func inputBinding() {
        
    }
    
    func outputBinding() {
        
    }
    
    
    
    
}
