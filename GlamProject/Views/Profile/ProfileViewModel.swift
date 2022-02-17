import UIKit
import RxSwift
import RxCocoa
import RxRelay
import RxDataSources
import Moya

protocol ProfileViewModelProtocol {
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
            .map { [weak self] type , value in
                guard let self = self else { return Profile(gender: .F) }
                var profile = self.output.userProfile.value
                switch type {
                case .bodyTypes :
                    profile.bodyType = BodyType(rawValue: value)
                case.educations :
                    profile.education = Education(rawValue: value)
                case .heightRange:
                    profile.height = Int(value)
                case .company:
                    profile.company = value
                case .job:
                    profile.job = value
                case .school:
                    profile.school = value
                case .introduction:
                    profile.introduction = value
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
        
        
//        output.userProfile
//            .bind(onNext: { [weak self] item in
//                self?.userManager.profile = item
//            })
//            .disposed(by: disposeBag)
          
    }
    
    
    
    
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
