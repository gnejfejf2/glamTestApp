import UIKit
import RxSwift
import RxCocoa
import RxRelay
import Moya

protocol ProfileViewModelProtocol {
    var networkAPI : NetworkingAPI { get }
    
    var coordinator : ProfileViewCoordinator? { get }
    
    func userProfileGet() -> ( Observable<Profile> , Observable<ProfileSubData> )
}


class ProfileViewModel : ViewModelProtocol , ProfileViewModelProtocol{
  
    var networkAPI : NetworkingAPI
    
    var coordinator : ProfileViewCoordinator?
    
    let userManager : UserDefaultsManager = UserDefaultsManager.shared
    
    
    struct Input {
        let changeValue = PublishSubject<(MetaDataType , String)>()
    }
    
    struct Output {
        let userProfile = BehaviorRelay<Profile>(value : Profile(gender: .F))
        var metaData = BehaviorRelay<ProfileSubData?>(value : nil)
      
    }
    
    
    let input = Input()
    let output = Output()
    private let disposeBag = DisposeBag()
    
    init(networkAPI : NetworkingAPI = NetworkingAPI.shared){
        self.networkAPI = networkAPI

        inputBinding()
        outputBinding()
        
      
    }
    
    
    func inputBinding() {
        input.changeValue
            .withLatestFrom(output.userProfile) {
                var profile = $1
                switch $0.0 {
                case .bodyTypes :
                    profile.bodyType = BodyType(rawValue: $0.1)
                case.educations :
                    profile.education = Education(rawValue: $0.1)
                case .heightRange:
                    profile.height = Int($0.1)
                case .company:
                    profile.company = $0.1
                case .job:
                    profile.job = $0.1
                case .school:
                    profile.school = $0.1
                case .introduction:
                    profile.introduction = $0.1
                }
                return profile
            }
            .bind(to: output.userProfile)
            .disposed(by: disposeBag)
    }
    
    func outputBinding() {
        userProfileGet().0
            .bind(to: output.userProfile)
            .disposed(by: disposeBag)
        
        userProfileGet().1
            .bind(to: output.metaData)
            .disposed(by: disposeBag)
        

    }
    
    
   
    
    
}
extension ProfileViewModelProtocol {
    
    
    func userProfileGet() -> ( Observable<Profile> , Observable<ProfileSubData> ){
        
        let network = networkAPI.request(type : ProfileResModel.self , .profile)
                .asObservable()
        
        let Profile = network
            .map{ $0.data }
            .compactMap{ $0 }

        let Meta = network
            .map{
                $0.meta
            }
            .compactMap{ $0 }
         
     
        return  (Profile , Meta)
    }
}
