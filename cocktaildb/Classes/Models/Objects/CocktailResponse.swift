import Foundation

struct CocktailResponse: Codable {
    
    let drinks: [CocktailItem]
    
    enum CodingKeys: String, CodingKey {
        case drinks
    }
}

struct CocktailItem: Codable {
    
    let idDrink: String
    let strDrink: String
    let strDrinkThumb: String
    
    enum CodingKeys: Int, CodingKey {
        case idDrink
        case strDrink
        case strDrinkThumb
    }
}
