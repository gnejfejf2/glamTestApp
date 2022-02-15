
import UIKit
import RxSwift
import RxCocoa
import RxRelay
import RxDataSources
import Moya

protocol HomeViewModelProtocol {

    var coordinator : HomeViewCoordinator { get }
 
}

class HomeViewModel : ViewModelProtocol , HomeViewModelProtocol{
    
    
    let networkAPI : NetworkingAPI = NetworkingAPI(provider: MoyaProvider<NetworkAPI>())
    var coordinator : HomeViewCoordinator
    
    
    
    struct Input {
        
    }
    
    struct Output {
      
        let daySchedules = BehaviorRelay<[MainIntroductionModel?]>(value: [])
    }
    
    let input = Input()
    let output = Output()
    private let disposeBag = DisposeBag()
    
    
    init(coordinator : HomeViewCoordinator){
        self.coordinator = coordinator
        getIntroduction()
    }
    
    
    func inputBinding() {
        
        
    }
    
    func outputBinding() {
        
    }
    
    func getIntroduction(){
        networkAPI.request(type : IntroductionResModel.self , .introduction)
            .asObservable()
            .map{ $0.data }
            .map({ data -> [MainIntroductionModel] in
                var MainIntroductionModels : [MainIntroductionModel] = []
                data.forEach{
                    print($0)
                    MainIntroductionModels.append(MainIntroductionModel(type: .Cell, data: $0))
                }
                return MainIntroductionModels
            })
            .bind(to: output.daySchedules)
            .disposed(by: disposeBag)
            
//            .map{ MainIntroductionModel(type: .Cell, data: $0) }
            
//            .bind(to: output.daySchedules)
//            .disposed(by: disposeBag)
//            .source.bind { element in
//                print(element)
//            }
            
//            .map(Introduction.self)
//            .map{ MainIntroductionModel(type: .Cell, data: $0) }
            
    }
    
    
    
}
