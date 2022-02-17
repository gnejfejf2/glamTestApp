import XCTest
import RxCocoa
import RxSwift
import RxTest
import Moya


@testable import GlamProject

class ProfileViewTests: XCTestCase {
    let disposeBag = DisposeBag()
    
    var viewModel: ProfileViewModel!
    var scheduler: TestScheduler!
    
    // MARK: - GIVEN
    override func setUp() {
        let mockNetworkingAPI =  NetworkingAPI(provider: MoyaProvider<GlamAPI>(stubClosure: { _ in .immediate }))
        viewModel = ProfileViewModel(networkAPI: mockNetworkingAPI)
        scheduler = TestScheduler(initialClock: 0, resolution: 0.01)
        
    }
    
    
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
    
    
    //삭제테스트
    func testPrfileEdit() {
        let observer = scheduler.createObserver(String.self)


//
        scheduler.createHotObservable([.next(100 , (.introduction , "소개글"))])
            .bind(to: viewModel.input.changeValue)
            .disposed(by: disposeBag)

//        scheduler.createHotObservable([.next(100 , (.bodyTypes , "통통"))])
//            .bind(to: viewModel.input.changeValue)
//            .disposed(by: disposeBag)
//
//        scheduler.createHotObservable([.next(100 , (.educations , "고등학교"))])
//            .bind(to: viewModel.input.changeValue)
//            .disposed(by: disposeBag)
//
//        scheduler.createHotObservable([.next(100 , (.company , ""))])
//            .bind(to: viewModel.input.changeValue)
//            .disposed(by: disposeBag)
//
//        scheduler.createHotObservable([.next(100 , (.job , ""))])
//            .bind(to: viewModel.input.changeValue)
//            .disposed(by: disposeBag)
//        scheduler.createHotObservable([.next(100 , (.school , "수성고등학교"))])
//            .bind(to: viewModel.input.changeValue)
//            .disposed(by: disposeBag)


        //
        viewModel.output.userProfile
            .map({ $0.introduction })
            .compactMap{ $0 }
            .bind(to: observer)
            .disposed(by: disposeBag)


        scheduler.start()




        let exceptEvents: [Recorded<Event<String>>] = [
            .next(0, "소개글이 지워지면 힌트가 나타나야 합니다"),
            .next(100, "소개글"),
            .completed(100)
        ]



        XCTAssertEqual(observer.events , exceptEvents)
    }
    

}


