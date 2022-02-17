//
//  Gender.swift
//  GlamTestApp
//
//  Created by Hwik on 2022/02/17.
//

import Foundation
import UIKit

enum Gender : String {
    case F = "여성"
    case M = "남성"
}
 
extension Gender: Codable {
    enum ErrorType: Error {
        case encoding
        case decoding
    }
    
    init(from decoder: Decoder) throws {
        let value = try decoder.singleValueContainer()
        let decodedValue = try value.decode(String.self)
        
        switch decodedValue {
        case "F":
            self = .F
        case "M":
            self = .M
        default:
            throw ErrorType.decoding
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var contrainer = encoder.singleValueContainer()
        
        switch self {
        case .F:
            try contrainer.encode("F")
        case .M:
            try contrainer.encode("M")
        }
    }
}
