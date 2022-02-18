

import Foundation
import UIKit

enum BodyType : String {
    case body_type_00 = "마른"
    case body_type_01 = "보통"
    case body_type_02 = "근육"
    case body_type_03 = "통통"

}
 
extension BodyType: Codable {
    enum ErrorType: Error {
        case encoding
        case decoding
    }
    
    init(from decoder: Decoder) throws {
        let value = try decoder.singleValueContainer()
        let decodedValue = try value.decode(String.self)
        
        switch decodedValue {
        case "body_type_00":
            self = .body_type_00
        case "body_type_01":
            self = .body_type_01
        case "body_type_02":
            self = .body_type_02
        case "body_type_03":
            self = .body_type_03
        default:
            throw ErrorType.decoding
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var contrainer = encoder.singleValueContainer()
        
        switch self {
        case .body_type_00:
            try contrainer.encode("body_type_00")
        case .body_type_01:
            try contrainer.encode("body_type_01")
        case .body_type_02:
            try contrainer.encode("body_type_02")
        case .body_type_03:
            try contrainer.encode("body_type_03")
        }
    }
}
