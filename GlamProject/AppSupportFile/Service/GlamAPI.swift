import Moya
import Alamofire
import RxSwift

typealias ApiParameter = [String : Any]

protocol NetworkingService {

    var jsonDecoder: JSONDecoder { get }
    
    func request<T: Decodable>(type : T.Type , _ api: GlamAPI) -> Single<T> 
    
}

final class NetworkingAPI: NetworkingService {
    static let shared : NetworkingAPI = NetworkingAPI()
    
    
    var jsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        return decoder
    }
    
    let provider: MoyaProvider<GlamAPI>
    
    //provider 객체 삽입
    init(provider: MoyaProvider<GlamAPI> = MoyaProvider<GlamAPI>()) {
        self.provider = provider
        
    
    }
    
    //데이터통신코드
    func request<T: Decodable>(type : T.Type , _ api: GlamAPI) -> Single<T> {
        return provider.rx
            .request(api)
            .filterSuccessfulStatusCodes()
            
            .map( T.self )
            
    }
  
    
    //데이터통신코드
    func requestTest(_ api: GlamAPI) -> Single<Response> {
        return provider.rx
            .request(api)
            .filterSuccessfulStatusCodes()
            
//            .map( T.self )
            
    }
}


enum GlamAPI{
    
    case introduction
    
    case introductionAdditional
    
    case introductionCustom
    
    case profile
    
    case custom(path : String , method : Moya.Method)
}





extension GlamAPI : TargetType {
    //BaseURL
    var baseURL: URL {
        return URL(string: "https://test.dev.cupist.de")!
    }
    var headers: [String: String]? {
        return [:]
    }
    
    //경로
    var path: String {
        switch self {
        case .introduction:
            return "/introduction"
        case .introductionAdditional:
            return "/introduction/additional"
        case .introductionCustom:
            return "/introduction/custom"
        case .profile:
            return "/profile"
        case .custom(path: let path, method: _):
            return path
        }
       
    }
    //통신을 get , post , put 등 무엇으로 할지 이곳에서 결정한다 값이 없다면 디폴트로 Get을 요청
    var method : Moya.Method {
        switch self {
        case .introductionCustom :
            return .post
        case .custom(path : _ , method: let method) :
            return method
        default :
            return .get
        }
    }
    //요청시 파라미터를 넣음
    var task: Task {
       
        
        return .requestPlain
    }
    
    var sampleData: Data {
        switch self {
        case .introduction:
            return stubbedResponse("Introduction")
        case .introductionAdditional:
            return stubbedResponse("IntroductionAdditional")
        case .introductionCustom:
            return stubbedResponse("IntroductionCustom")
        case .profile:
            return stubbedResponse("Profile")
        case .custom(path: let path, method: _):
            let filePath = path.components(separatedBy: ["/"]).joined()
       
            
            return stubbedResponse(filePath)
        }
    }
    
    func stubbedResponse(_ filename: String) -> Data! {
        
        
        let bundlePath = Bundle.main.path(forResource: "Json", ofType: "bundle")
        let bundle = Bundle(path: bundlePath!)
        let path = bundle?.path(forResource: filename, ofType: "json")
        print(filename)
        return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
    }
    
    
    
}
