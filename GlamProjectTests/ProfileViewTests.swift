import XCTest
import RxCocoa
import RxSwift
import RxTest
import Moya


@testable import GlamProject

class ProfileViewTests: XCTestCase {
    let disposeBag = DisposeBag()
    var viewController : ProfileViewController!
    var viewModel: ProfileViewModel!
    var scheduler: TestScheduler!
    
    // MARK: - GIVEN
    override func setUp() {
        let mockNetworkingAPI =  NetworkingAPI(provider: MoyaProvider<GlamAPI>(stubClosure: { _ in .immediate }))
        viewController = ProfileViewController()
        viewModel = ProfileViewModel(networkAPI: mockNetworkingAPI)
        scheduler = TestScheduler(initialClock: 0, resolution: 0.01)
        
    }
    
    //유저 프로필 정상적으로 가져오는지 테스트
    func testUserProfileGet(){
        let observer = scheduler.createObserver(Int?.self)
        
        viewModel.userProfileGet().0
            .map({ $0.id })
            .bind(to: observer)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        let exceptEvents: [Recorded<Event<Int?>>] = [
            .next(0 , 0),
            .completed(0)
        ]
        XCTAssertEqual(observer.events , exceptEvents)
    }
    
    //메타 데이터 불러오는 테스트
    func testUserMetaGet(){
        let observer = scheduler.createObserver(Int?.self)
        
        viewModel.userProfileGet().1
            .map({ $0.bodyTypes?.count })
            .bind(to: observer)
            .disposed(by: disposeBag)
        
        
        scheduler.start()
        
        let exceptEvents: [Recorded<Event<Int?>>] = [
            .next(0 , 4),
            .completed(0)
        ]
        XCTAssertEqual(observer.events , exceptEvents)
    }
    
    
    //데이터 변경 테스트
    func testPrfileEdit() {
        let observer = scheduler.createObserver(Profile.self)
        
        
        //
        scheduler.createHotObservable([.next(100 , (.introduction , "소개글"))])
            .bind(to: viewModel.input.changeValue)
            .disposed(by: disposeBag)
        
        scheduler.createHotObservable([.next(200 , (.bodyTypes , "통통"))])
            .bind(to: viewModel.input.changeValue)
            .disposed(by: disposeBag)
        
        scheduler.createHotObservable([.next(300 , (.educations , "고등학교"))])
            .bind(to: viewModel.input.changeValue)
            .disposed(by: disposeBag)
        
        scheduler.createHotObservable([.next(400 , (.company , ""))])
            .bind(to: viewModel.input.changeValue)
            .disposed(by: disposeBag)
        
        scheduler.createHotObservable([.next(500 , (.job , ""))])
            .bind(to: viewModel.input.changeValue)
            .disposed(by: disposeBag)
        scheduler.createHotObservable([.next(600 , (.school , "수성고등학교"))])
            .bind(to: viewModel.input.changeValue)
            .disposed(by: disposeBag)
        
        scheduler.createHotObservable([.next(700 , (.heightRange , "180"))])
            .bind(to: viewModel.input.changeValue)
            .disposed(by: disposeBag)
        
        //
        viewModel.output.userProfile
            .map({ $0 })
            .compactMap{ $0 }
            .bind(to: observer)
            .disposed(by: disposeBag)
        
        
        scheduler.start()
        
        
        
        let exceptEvents: [Recorded<Event<Profile>>] = [
            .next(0, Profile(bodyType: .body_type_00, birthday: "1990-01-01", company: "큐피스트", education: nil, gender: .F, height: 170, id: 0, introduction: "소개글이 지워지면 힌트가 나타나야 합니다", job: "개발자", location: "서울특별시 강남구", name: "개발자 A", pictures: [ "/profile/01.png","/profile/02.png"], school: nil)),
            .next(100, Profile(bodyType: .body_type_00, birthday: "1990-01-01", company: "큐피스트", education: nil, gender: .F, height: 170, id: 0, introduction: "소개글", job: "개발자", location: "서울특별시 강남구", name: "개발자 A", pictures: [ "/profile/01.png","/profile/02.png"], school: nil)),
            .next(200, Profile(bodyType: .body_type_03, birthday: "1990-01-01", company: "큐피스트", education: nil, gender: .F, height: 170, id: 0, introduction: "소개글", job: "개발자", location: "서울특별시 강남구", name: "개발자 A", pictures: [ "/profile/01.png","/profile/02.png"], school: nil)),
            .next(300, Profile(bodyType: .body_type_03, birthday: "1990-01-01", company: "큐피스트", education: .education_00, gender: .F, height: 170, id: 0, introduction: "소개글", job: "개발자", location: "서울특별시 강남구", name: "개발자 A", pictures: [ "/profile/01.png","/profile/02.png"], school: nil)),
            .next(400, Profile(bodyType: .body_type_03, birthday: "1990-01-01", company: "", education: .education_00, gender: .F, height: 170, id: 0, introduction: "소개글", job: "개발자", location: "서울특별시 강남구", name: "개발자 A", pictures: [ "/profile/01.png","/profile/02.png"], school: nil)),
            .next(500, Profile(bodyType: .body_type_03, birthday: "1990-01-01", company: "", education: .education_00, gender: .F, height: 170, id: 0, introduction: "소개글", job: "", location: "서울특별시 강남구", name: "개발자 A", pictures: [ "/profile/01.png","/profile/02.png"], school: nil)),
            .next(600, Profile(bodyType: .body_type_03, birthday: "1990-01-01", company: "", education: .education_00, gender: .F, height: 170, id: 0, introduction: "소개글", job: "", location: "서울특별시 강남구", name: "개발자 A", pictures: [ "/profile/01.png","/profile/02.png"], school: "수성고등학교")),
            .next(700, Profile(bodyType: .body_type_03, birthday: "1990-01-01", company: "", education: .education_00, gender: .F, height: 180, id: 0, introduction: "소개글", job: "", location: "서울특별시 강남구", name: "개발자 A", pictures: [ "/profile/01.png","/profile/02.png"], school: "수성고등학교"))
        ]
        
        
        
        XCTAssertEqual(observer.events , exceptEvents)
    }
    
    
    func testDommyStringAdd(){
        var testArray : [Int] = []
        testArray.append(viewController.dommyStringAdd(items: []).count)
        testArray.append(viewController.dommyStringAdd(items: ["1"]).count)
        testArray.append(viewController.dommyStringAdd(items: ["2","3","3","3","3","3"]).count)
        testArray.append(viewController.dommyStringAdd(items: ["2","3","3","3","3","3","2","3","3","3","3","3"]).count)
       
        
        
        XCTAssertEqual(testArray, [6,6,6,6])
    }
    
    func testOpenBodyPopUp(){
        viewController.openPopUp(type: .bodyTypes, data: [])
        
        XCTAssertEqual((viewController.openPopUpView != nil) , true)
        XCTAssertEqual((viewController.openPopUpView?.titleLabel.text == "체형") , true)
        
     
    }
    func testOpenEducationPopUp(){
        viewController.openPopUp(type: .educations, data: [])
        
        XCTAssertEqual((viewController.openPopUpView != nil) , true)
        XCTAssertEqual((viewController.openPopUpView?.titleLabel.text == "학력") , true)
        
     
    }
    
    func testOpenHeightPopUp(){
        viewController.openHeightPopUp(type: .heightRange, data: 0...10)
        
        XCTAssertEqual((viewController.openPopUpView != nil) , true)
        
        
        XCTAssertEqual((viewController.openPopUpView?.titleLabel.text == "키") , true)
    }
}




