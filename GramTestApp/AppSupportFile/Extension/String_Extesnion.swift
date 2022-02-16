//
//  String_Extesnion.swift
//  GramTestApp
//
//  Created by Hwik on 2022/02/15.
//

import Foundation


extension String {
    
    func getImageURL() -> URL {
        let url = URL(string: "https://test.dev.cupist.de" + self)!
        return url
    }
    
}
