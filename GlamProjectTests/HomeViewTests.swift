import XCTest
import RxCocoa
import RxSwift
import RxTest
import Moya


@testable import GlamProject

class HomeViewTests: XCTestCase {
    let disposeBag = DisposeBag()
    var viewController : HomeViewController!
    var viewModel: HomeViewModel!
    var scheduler: TestScheduler!
    
    // MARK: - GIVEN
    override func setUp() {
        let mockNetworkingAPI =  NetworkingAPI(provider: MoyaProvider<GlamAPI>(stubClosure: { _ in .immediate }))
        viewController = HomeViewController()
        viewModel = HomeViewModel(networkAPI: mockNetworkingAPI)
        scheduler = TestScheduler(initialClock: 0, resolution: 0.01)
        
    }
    
    
    func testTodayPickIntroductionGet(){
        let observer = scheduler.createObserver(MainIntroductionType?.self)
        
        viewModel.todayPickIntroductionGet()
            .map({ $0.first?.cellType })
            .bind(to: observer)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        let exceptEvents: [Recorded<Event<MainIntroductionType?>>] = [
            .next(0 , .TodayPick),
            .completed(0)
        ]
        XCTAssertEqual(observer.events , exceptEvents)
    }
    
    func testCustomPickIntroductionGet(){
        let observer1 = scheduler.createObserver(MainIntroductionType?.self)
        viewModel.customPickCellAdd()
            .map({ $0.first?.cellType })
            .bind(to: observer1)
            .disposed(by: disposeBag)
        
        
        scheduler.start()
        
        let exceptEvents1: [Recorded<Event<MainIntroductionType?>>] = [
            .next(0, .Customize),
            .completed(0)
        ]
        
        XCTAssertEqual(observer1.events , exceptEvents1)
        
        
        
    }
    
    
    
    
    //처음 뷰모델을 선언할때
    //최초값을 가져왓고 다음페이지는 없으므로 NIL이 찍히는게 맞다
    func testAddPickMetaDataIntroductionGet() {
        let observer = scheduler.createObserver(NextModel?.self)
        
        
        let _ = viewModel.addPickIntroductionGet()
        
        viewModel.output.nextPage
            .map({ $0 })
            .bind(to: observer)
            .disposed(by: disposeBag)
        
        
        scheduler.start()
        
        let exceptEvents: [Recorded<Event<NextModel?>>] = [
            .next(0, nil)
        ]
        
        XCTAssertEqual(observer.events , exceptEvents)
        
    }
    
    func testAddModelAfter(){
        let observer2 = scheduler.createObserver([Int].self)
        
        scheduler.createHotObservable([.next(100 , () )])
            .bind(to: viewModel.input.readAdd)
            .disposed(by: disposeBag)
        
        scheduler.createHotObservable([.next(200 , () )])
            .bind(to: viewModel.input.readAdd)
            .disposed(by: disposeBag)
        
        
        viewModel.output.mainIntroductionModels
            .map({
                $0.filter{ $0.cellType != .Customize }
                .map { $0.data.id }
            })
            .bind(to: observer2)
            .disposed(by: disposeBag)
        
        
        scheduler.start()
        
        let exceptEvents2: [Recorded<Event<[Int]>>] = [
            .next(0, [1,2,3,4]),
            .next(100, [1,2,3,4,5,6]),
        ]
        
        XCTAssertEqual(observer2.events , exceptEvents2)
    }
    
    func testCustomAddModelAfter(){
        let observer2 = scheduler.createObserver([Int].self)
        
        scheduler.createHotObservable([.next(100 , () )])
            .bind(to: viewModel.input.customAdd)
            .disposed(by: disposeBag)
        
        scheduler.createHotObservable([.next(200 , () )])
            .bind(to: viewModel.input.customAdd)
            .disposed(by: disposeBag)
        
        
        viewModel.output.mainIntroductionModels
            .map({
                $0.filter{ $0.cellType != .Customize }
                .map { $0.data.id }
            })
            .bind(to: observer2)
            .disposed(by: disposeBag)
        
        
        scheduler.start()
        
        let exceptEvents2: [Recorded<Event<[Int]>>] = [
            .next(0, [1,2,3,4]),
            .next(100, [7,8,1,2,3,4]),
            .next(200, [7,8,1,2,3,4])
        ]
        
        XCTAssertEqual(observer2.events , exceptEvents2)
    }
    
    
    //삭제테스트
    func testRemoveIntroductionGet() {
        let observer = scheduler.createObserver(Int?.self)
        
        let itemCount = viewModel.output.mainIntroductionModels.value.count
        
        scheduler.createHotObservable([ .next(100 , MainIntroductionModel(cellType: .TodayPick, data: Introduction(id: 1, age: 0, name: "", company: "", distance: 0, height: 0, introduction: "", job: "", location: "", pictures: [])) )])
            .bind(to: viewModel.input.removeAction)
            .disposed(by: disposeBag)
        
        
        scheduler.createHotObservable([ .next(200 , MainIntroductionModel(cellType: .TodayPick, data: Introduction(id: 4, age: 0, name: "", company: "", distance: 0, height: 0, introduction: "", job: "", location: "", pictures: [])) )])
            .bind(to: viewModel.input.removeAction)
            .disposed(by: disposeBag)
        
        viewModel.output.mainIntroductionModels
            .map({ $0.count })
            .bind(to: observer)
            .disposed(by: disposeBag)
        
        
        scheduler.start()
        
        
        
        
        let exceptEvents: [Recorded<Event<Int?>>] = [
            .next(0, itemCount),
            .next(100, itemCount - 1),
            .next(200, itemCount - 2)
        ]
        
        
        
        XCTAssertEqual(observer.events , exceptEvents)
    }
    
    
    
    //데이터 셋팅 체크
    func testFirtIntroducationGetChecking(){
        let observer = scheduler.createObserver(Int?.self)
        
        //
        viewModel.output.mainIntroductionModels
            .map({ $0.count })
            .bind(to: observer)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        let exceptEvents: [Recorded<Event<Int?>>] = [
            .next(0, 5)
        ]
        XCTAssertEqual(observer.events , exceptEvents)
        
    }
    //CellType으로 들어갔는지 체크
    func testFirstIntroducationCellChekcing(){
        let observer = scheduler.createObserver(MainIntroductionType?.self)
        
        
        viewModel.output.mainIntroductionModels
            .map({ $0.first?.cellType })
            .bind(to: observer)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        let exceptEvents: [Recorded<Event<MainIntroductionType?>>] = [
            .next(0, .TodayPick)
        ]
        
        XCTAssertEqual(observer.events , exceptEvents)
        
    }
    
    func testAddPickIntroductionGet() {
        let observer = scheduler.createObserver(MainIntroductionType?.self)
        
        viewModel.addPickIntroductionGet()
            .map({ $0.first?.cellType })
            .bind(to: observer)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        let exceptEvents: [Recorded<Event<MainIntroductionType?>>] = [
            .next(0, .AddPick),
            .completed(0)
        ]
        
        XCTAssertEqual(observer.events , exceptEvents)
    }
    
    func testHomeGetPageViewControllers(){
        let count = viewController.getPageViewControllers().count
        
        
        XCTAssertEqual(count, 3)
        
    }
    
}
