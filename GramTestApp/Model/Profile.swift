import Foundation

// MARK: - DataClass
struct Profile : Codable {
    var birthday, bodyType, company: String?
    var education: String?
    var gender: String?
    var height, id: Int?
    var introduction, job, location, name: String?
    var pictures: [String]?
    var school: String?
}


struct Meta: Codable {
    var bodyTypes, educations, genders: [MetaValue]?
    var heightRange: HeightRange?
}


struct MetaValue: Codable {
    var key, name : String
}


struct HeightRange: Codable {
    var max, min: Int?
}
