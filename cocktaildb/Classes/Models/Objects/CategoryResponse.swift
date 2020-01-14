import Foundation

typealias Codable = Encodable & Decodable

struct CategoryResponse: Codable {
    let drinks: [CocktailCategory]
    
    enum CodingKeys: String, CodingKey {
        case drinks
    }
}

struct CocktailCategory: Codable {
    let strCategory: String
    
    enum CodingKeys: String, CodingKey {
        case strCategory
    }
}
