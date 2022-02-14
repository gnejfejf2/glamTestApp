//
//  GramAPI.swift
//  GramTestApp
//
//  Created by Hwik on 2022/02/14.
//
import Moya

import Alamofire
import RxSwift

typealias ApiParameter = [String : Any]

protocol NetworkingService {

    var jsonDecoder: JSONDecoder { get }
    
    func request<T: Decodable>(_ api: NetworkAPI) -> Single<T>
    
}

final class NetworkingAPI: NetworkingService {
    static let shared : NetworkingAPI = NetworkingAPI()
    
    
    var jsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        return decoder
    }
    
    let provider: MoyaProvider<NetworkAPI>
    
    //provider 객체 삽입
    init(provider: MoyaProvider<NetworkAPI> = MoyaProvider<NetworkAPI>()) {
        self.provider = provider
    }
    
    //데이터통신코드
    func request<T: Decodable>(_ api: NetworkAPI) -> Single<T> {
        return provider.rx
            .request(api)
            .filterSuccessfulStatusCodes()
            .map( T.self )
    }
  
}


enum NetworkAPI{
    
    case introduction
    
    case introductionAdditional
    
    case introductionCustom
    
    case profile
}





extension NetworkAPI : TargetType {
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
        }
       
    }
    //통신을 get , post , put 등 무엇으로 할지 이곳에서 결정한다 값이 없다면 디폴트로 Get을 요청
    var method : Moya.Method {
        switch self {
        case .introductionCustom :
            return .post
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
            return stubbedResponse("stubbedResponse")
        case .introductionAdditional:
            return stubbedResponse("introductionAdditional")
        case .introductionCustom:
            return stubbedResponse("introductionCustom")
        case .profile:
            return stubbedResponse("profile")
        }
    }
    
    func stubbedResponse(_ filename: String) -> Data! {
        let bundlePath = Bundle.main.path(forResource: "Stub", ofType: "bundle")
        let bundle = Bundle(path: bundlePath!)
        let path = bundle?.path(forResource: filename, ofType: "json")
        return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
    }
    
}
