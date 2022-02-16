import UIKit
import RxSwift
import RxCocoa
import RxRelay
import RxDataSources
import Moya

protocol ProfileViewModelProtocol {
    var coordinator : ProfileViewCoordinator? { get }
 
}


class ProfileViewModel : ViewModelProtocol , ProfileViewModelProtocol{
    var networkAPI : NetworkingAPI
    
    var coordinator : ProfileViewCoordinator?
    
    struct Input {
       
    }
    
    struct Output {
        let imageModels = BehaviorRelay<[String]>(value: ["1","2","3"])
    }
    
    let input = Input()
    let output = Output()
    
    
    init(networkAPI : NetworkingAPI = NetworkingAPI.shared){
        self.networkAPI = networkAPI
        
    }
    
    
    func inputBinding() {
        
    }
    
    func outputBinding() {
        
    }
    
    
    
    
}
