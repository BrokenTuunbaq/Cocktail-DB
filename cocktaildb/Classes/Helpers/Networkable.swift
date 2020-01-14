import Foundation
import Moya

protocol Networkable {
    var provider: MoyaProvider<CocktailAPI> { get }
    var cocktailsCategoryLogic: CocktailCategoryLogic { get }
    
    func categories(completion: @escaping ([String]?, Error?) -> ())
    func cocktailsByCategory(categoryName: String, completion: @escaping ([CocktailItem]?, Error?) -> ())
}
