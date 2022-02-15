//
//  GramTestAppTests.swift
//  GramTestAppTests
//
//  Created by Hwik on 2022/02/14.
//

import XCTest
import RxTest
import RxSwift

@testable import GramTestApp

class GramAppDelegateTest: XCTestCase {

//    appMainCoordinator = AppMainCoordinator(navigationController)
//    appMainCoordinator?.start()
    let disposeBag = DisposeBag()
    
  
    var scheduler: TestScheduler!
    // MARK: - GIVEN

    var appMainCoordinator : AppMainCoordinator!
    
    override func setUp() {
        //앱시작
        appMainCoordinator = AppMainCoordinator(UINavigationController())
        //탭바 시작
        appMainCoordinator.start()
      
    }

    
    
    
      
    
    //탭의 갯수가 5개인지 체크
    func testTapBarCountChecking() throws {
        // MARK: - WHEN
        let tapBarCount : Int = appMainCoordinator.tabBarCoordinator?.tabBarController.children.count ?? 0
        XCTAssertEqual(tapBarCount, 5)
    }
    //탭의 시작값이 정상적으로 0인지 체크
    func testTapBarSelectedChecking() throws {
        // MARK: - WHEN
        let tapBarSelected : Int = appMainCoordinator.tabBarCoordinator?.tabBarController.selectedIndex ?? 5
        XCTAssertEqual(tapBarSelected, 0)
    }
    
    
}
