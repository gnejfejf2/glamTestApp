
import Foundation

struct MainIntroductionModel : Equatable , Hashable {
    static func == (lhs: MainIntroductionModel, rhs: MainIntroductionModel) -> Bool {
       
        return lhs.data.id == rhs.data.id
    }
    func hash(into hasher: inout Hasher) {
//        hasher.combine(cellType.hashValue)
        hasher.combine(data.id)
    }
   
    var cellType : MainIntroductionType
    var data : Introduction
    
    
    
}
