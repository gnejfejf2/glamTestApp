

import Foundation

enum CustomPickItem : Codable{
    
    case glam
    case top
    case body
    case pet
    
    func returnModel() -> CustopPickModel{
        switch self {
        case .glam:
            return CustopPickModel(name: "글램 추천", iconName: "today", hot: true)
        case .top:
            return CustopPickModel(name: "최상위 매력", iconName: "dia", hot: true)
        case .body:
            return CustopPickModel(name: "볼륨감 있는 체형", iconName: "glamour", hot: true)
        case .pet:
            return CustopPickModel(name: "반려 동물을 키우는", iconName: "today", hot: false)
        }
        
        
        
    }
    
    
}

struct CustopPickModel : Equatable {
     var name : String
    var iconName : String
    var hot : Bool
    
}
