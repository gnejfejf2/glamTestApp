import Foundation


enum HomePageTapBar : String{
    
    case Main = "logo"
    case Closely = "근처"
    case Live = "피드"
    
    
    
    func pageOrderNumber() -> Int {
        switch self {
        case .Main:
            return 0
        case .Closely:
            return 1
        case .Live:
            return 2
        }
    }
}
