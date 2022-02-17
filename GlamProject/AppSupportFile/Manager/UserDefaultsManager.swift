//
//  UserDefaultsManager.swift
//  GlamTestApp
//
//  Created by Hwik on 2022/02/17.
//

import Foundation
import UIKit

//내부저장소를 관리하는 매니저
class UserDefaultsManager {
    
    static let shared: UserDefaultsManager =  UserDefaultsManager()
    
    @Storage(key: USER_KEY.Profile.rawValue, defaultValue : Profile(gender: .F))
    var profile : Profile
    
  


}
