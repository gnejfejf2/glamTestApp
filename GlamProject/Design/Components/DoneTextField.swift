
import UIKit

class DoneTextField: UITextField , UITextFieldDelegate {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        uiSetting()
        self.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        uiSetting()
        self.delegate = self
    }
    
    var doneAction : FunctionCloure? = nil
    
    func uiSetting(){
        let toolBarKeyboard = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        toolBarKeyboard.sizeToFit()
         let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let buttonDoneBar = UIBarButtonItem(title: "닫기", style: .done, target: self, action: #selector(doneButtonAction))
        toolBarKeyboard.items = [flexSpace , buttonDoneBar]
        self.inputAccessoryView = toolBarKeyboard
    }
  

    
    @objc func doneButtonAction(){
        doneAction?()
        resignFirstResponder()
    }

   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        doneAction?()
        resignFirstResponder()
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        
    }

    
    
}
