
import UIKit
import RxSwift
import RxCocoa
import RxRelay
import Moya

protocol HomeViewModelProtocol {
    
    var coordinator : HomeViewCoordinator? { get }
    func getIntroduction()
    func todayPickIntroductionGet() -> Observable<[MainIntroductionModel]>
    func customPickCellAdd() -> Observable<[MainIntroductionModel]>
    func addPickIntroductionGet() -> Observable<[MainIntroductionModel]>
    func customPickIntroductionGet() -> Observable<[MainIntroductionModel]>
    func makeMainIntroductionModel(items : [Introduction] , cellType : MainIntroductionType ) -> [MainIntroductionModel]
}

class HomeViewModel : ViewModelProtocol , HomeViewModelProtocol{
    
    
    
    
    let networkAPI : NetworkingAPI
    var coordinator : HomeViewCoordinator?
    
    
    
    struct Input {
        let customAdd = PublishSubject<Void>()
        let readAdd = PublishSubject<Void>()
        let moveSettingView = PublishSubject<Void>()
        let removeAction = PublishSubject<MainIntroductionModel>()
    }
    
    struct Output {
        let mainIntroductionModels = BehaviorRelay<[MainIntroductionModel]>(value: [])
        let nextPage = BehaviorRelay<NextModel?>(value: nil)
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
        
        input.removeAction
            .map { [weak self] removedItem in
                guard let self = self else { return [] }
                return self.output.mainIntroductionModels.value.filter { $0.data.id != removedItem.data.id }
            }
            .bind(to: output.mainIntroductionModels)
            .disposed(by: disposeBag)
        
        input.readAdd
            .asObservable()
            .filter{ [weak self] in  self?.output.nextPage.value != nil }
            .flatMapLatest { [self] in
                self.addPickIntroductionGet()
            }
            .withLatestFrom(output.mainIntroductionModels) { $1 + $0 }
            .bind(to: output.mainIntroductionModels)
            .disposed(by: disposeBag)
        
        input.customAdd
            .asObservable()
            .flatMapLatest { [self] in
                self.customPickIntroductionGet()
            }
            .withLatestFrom(output.mainIntroductionModels) { $0 + $1 }
            .map{ $0.removingDuplicates() }
            .bind(to: output.mainIntroductionModels)
            .disposed(by: disposeBag)
        
        
        input.moveSettingView
            .subscribe { [weak self] _ in
                self?.coordinator?.dommyViewOpen()
            }.disposed(by: disposeBag)
        
    }
    
    func outputBinding() {
        getIntroduction()
        
    }
    
    func getIntroduction(){
        let baseIntroduction = todayPickIntroductionGet()
        let customCell = customPickCellAdd()
        let addIntroduction = addPickIntroductionGet()
        
        
        
        Observable.zip(baseIntroduction , customCell , addIntroduction)
            .map { $0 + $1 + $2 }
            .bind(to: output.mainIntroductionModels)
            .disposed(by: disposeBag)
        
    }
    
    
    func todayPickIntroductionGet() -> Observable<[MainIntroductionModel]>{
        networkAPI.request(type : IntroductionResModel.self , .introduction)
            .asObservable()
            .map{ $0.data }
            .map({ [weak self] data -> [MainIntroductionModel] in
                guard let self = self else { return [] }
                return self.makeMainIntroductionModel(items: data , cellType : .TodayPick)
            })
            .catch { error  in
                return Observable<[MainIntroductionModel]>.just([])
            }
        
    }

    func customPickCellAdd() -> Observable<[MainIntroductionModel]>{
        Single<[MainIntroductionModel]>.just([MainIntroductionModel(cellType: .Customize , data: Introduction(id:UUID().uuidString.hashValue, age: 0, name: "", company: nil, distance: nil, height: nil, introduction: nil, job: nil, location: nil, pictures: nil))])
            .asObservable()
    }
    
    
    func addPickIntroductionGet() -> Observable<[MainIntroductionModel]>{
        var result : Single<IntroductionAddResModel>
        
        
        if let value = output.nextPage.value {
            result = networkAPI.request(type : IntroductionAddResModel.self , .custom(path: value.url , method: Moya.Method(rawValue: value.method)))
        }else{
            result = networkAPI.request(type : IntroductionAddResModel.self , .introductionAdditional)
        }
        
        result
            .asObservable()
            .map{ $0.meta.next }
            .catch { error  in
                return Observable<NextModel?>.just(nil)
            }
            .bind(to: output.nextPage)
            .disposed(by: disposeBag)
           
        
        return result
            .asObservable()
            .map{ $0.data }
            .map({ [weak self] data -> [MainIntroductionModel] in
                guard let self = self else { return [] }
                return self.makeMainIntroductionModel(items: data , cellType : .AddPick)
            })
            .catch { error  in
                return Observable<[MainIntroductionModel]>.just([])
            }
    }
    
    func customPickIntroductionGet() -> Observable<[MainIntroductionModel]>{
        networkAPI.request(type : IntroductionResModel.self , .introductionCustom)
            .asObservable()
            .map{ $0.data }
            .map({ [weak self] data -> [MainIntroductionModel] in
                guard let self = self else { return [] }
                return self.makeMainIntroductionModel(items: data , cellType : .AddPick)
            })
            .catch { error  in
                return Observable<[MainIntroductionModel]>.just([])
            }
    }
    
    
    func makeMainIntroductionModel(items : [Introduction] , cellType : MainIntroductionType ) -> [MainIntroductionModel]{
        var mainIntroductionModels : [MainIntroductionModel] = []
        items.forEach{
            mainIntroductionModels.append(MainIntroductionModel(cellType: cellType, data: $0))
        }
        return mainIntroductionModels
    }
    
    
}


