//
//  Meta.swift
//  GlamTestApp
//
//  Created by Hwik on 2022/02/16.
//

import Foundation


struct MetaModel : Codable {
    var next : NextModel?
}


struct NextModel : Hashable , Codable {
    var id: Int
    var method, url: String
}
