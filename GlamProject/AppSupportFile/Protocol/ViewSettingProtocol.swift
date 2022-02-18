import Foundation
import UIKit
import RxSwift


//뷰상단에 변수를 선언할때 or UI를 선언할때
//순서
// UI -> DataSource -> 변수 -> 기타값

protocol ViewSettingProtocol {
    
    //uiSetting
    //view.add , snp 옵션 로직등이 이곳에서 설정된다
    func uiDrawing()
    //ui 옵션들이 설정되는공간이다
    //델리게이트설정 , 백그라운드설정 등이 이루어진다
    func uiSetting()
    //ui 관련된 데이터들을 바인딩 시키는공간이다.
    func uiBinding()
    //버튼클릭 , 테이블뷰 클릭 등 화면에서 일어나는 이벤트들을 바인딩 시키는공간
    func eventBinding()
}


class SuperViewControllerSetting : UIViewController , ViewSettingProtocol {
    
    let disposeBag = DisposeBag()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        uiDrawing()
        uiSetting()
        uiBinding()
        eventBinding()
    }
    
    func uiDrawing() {
        view.backgroundColor = .white
     
    }
    
    func uiSetting() {

       
    }
    
    func uiBinding() {
        
    }
    
    func eventBinding() {
        
    }
    

}
