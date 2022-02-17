import Foundation

// MARK: - DataClass
struct Profile : Codable, Equatable{
    var bodyType : BodyType?
    var birthday , company : String?
    var education: Education?
    var gender: Gender
    var height, id: Int?
    var introduction, job, location, name: String?
    var pictures: [String]?
    var school: String?
    
    
    enum CodingKeys: String, CodingKey {
       
        case birthday
        case education
        case bodyType = "body_type"
        case company
        case gender
        case height
        case id
        case introduction
        case job
        case name
        case location
        case pictures
        case school
        
    }
    
    
}


struct ProfileSubData: Codable {
    var bodyTypes , educations, genders: [MetaValue]?
    var heightRange: HeightRange?
    
    
    enum CodingKeys: String, CodingKey {
       
        case educations
        case bodyTypes = "body_types"
        case genders
        case heightRange = "height_Range"
       
    }
    
}

struct KeyValue {
    var key : String
    var value : String
}

struct MetaValue: Codable {
    var key, name : String
}


struct HeightRange: Codable {
    var max, min: Int?
}



 
