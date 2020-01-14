import Foundation
import Moya

enum CocktailAPI {
    case categories
    case cocktailsByCategory(String)
}
