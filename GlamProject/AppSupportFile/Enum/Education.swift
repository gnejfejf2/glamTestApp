import UIKit

enum Education : String {
    case education_00 = "고등학교"
    case education_01 = "전문대"
    case education_02 = "대학교"
    case education_03 = "석사"
    case education_04 = "박사"
    case education_05 = "기타"
}
 
extension Education: Codable {
    enum ErrorType: Error {
        case encoding
        case decoding
    }
    
    init(from decoder: Decoder) throws {
        let value = try decoder.singleValueContainer()
        let decodedValue = try value.decode(String.self)
        
        switch decodedValue {
        case "education_00":
            self = .education_00
        case "education_01":
            self = .education_01
        case "education_02":
            self = .education_02
        case "education_03":
            self = .education_03
        case "education_04":
            self = .education_04
        case "education_05":
            self = .education_05
        default:
            throw ErrorType.decoding
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var contrainer = encoder.singleValueContainer()
        
        switch self {
        case .education_00:
            try contrainer.encode("education_00")
        case .education_01:
            try contrainer.encode("education_01")
        case .education_02:
            try contrainer.encode("education_02")
        case .education_03:
            try contrainer.encode("education_03")
        case .education_04:
            try contrainer.encode("education_04")
        case .education_05:
            try contrainer.encode("education_05")
        }
    }
}
