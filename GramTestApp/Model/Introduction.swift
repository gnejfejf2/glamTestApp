//
//  introductionModel.swift
//  GramTestApp
//
//  Created by Hwik on 2022/02/15.
//

import Foundation


struct Introduction : Codable {
    let id : Int
    //나이와 이름은 필수 값 같음
    let age : Int
    let name : String
    let company: String?
    let distance, height : Int?
    let introduction: String?
    let job, location : String?
    let pictures: [String]?
    
    
    func jobDistanceText() -> String{
        var items : [String] = []
        
        var text : String = ""
        
        if let job = job {
            items.append(job)
        }
        
        if let distance = distance {
            items.append(distance.getKmMToString())
        }
       
        items.forEach{
            if(text == ""){
                text += $0
            }else{
                text += " ・ " + $0
            }
        }
        return text
    }
    
    func heightText() -> String?{
        
        if let height = height {
            return String(height) + "cm"
        }else{
            return nil
        }
        
    }
    
    
}
