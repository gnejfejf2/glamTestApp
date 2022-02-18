
import UIKit
import SnapKit

class DevideLineView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        uiSetting()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        uiSetting()
   }
    
    func uiSetting(){
        self.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.width.equalTo(UIScreen.main.bounds.width)
        }
        
        
        backgroundColor = .gray1
    }

}
