
import Foundation
import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources
import RxRelay
import RxGesture


class TalkViewController: UIViewController , ViewSettingProtocol {
    
    private let disposeBag = DisposeBag()
    
    var viewModel : TalkViewModel?
   
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiDrawing()
        uiSetting()
        uiBinding()
        eventBinding()
    }
    
    func uiDrawing() {
        view.backgroundColor = .primaryColorReverse
     
    }
    
    func uiSetting() {

       
    }
    
    func uiBinding() {
        
    }
    
    func eventBinding() {
        
    }
    

}
