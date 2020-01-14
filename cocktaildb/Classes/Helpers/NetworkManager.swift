import Foundation
import Moya

class NetworkManager: Networkable {
    var cocktailsCategoryLogic = CocktailCategoryLogic()
    var provider = MoyaProvider<CocktailAPI>()
    
    /// Returns cocktails for one category
    /// - Parameters:
    ///   - categoryName: category name
    ///   - completion: array of cocktail items
    func cocktailsByCategory(categoryName: String, completion: @escaping ([CocktailItem]?, Error?) -> ()) {
        provider.request(.cocktailsByCategory(categoryName)) { result in
            switch result {
            case let .success(moyaResponse):
                let decoder = JSONDecoder()
                do {
                    let cocktailResponse = try decoder.decode(CocktailResponse.self, from: moyaResponse.data)
                    completion(cocktailResponse.drinks, nil)
                }
                catch {
                    print("Error: did not receive any cocktails")
                }
            case .failure(_): break
            }
        }
    }
        
    /// Returns all categories
    /// - Parameter completion: array of categories
    func categories(completion: @escaping ([String]?, Error?) -> ()) {
        provider.request(.categories) { result in
            switch result {
            case let .success(moyaResponse):
                let decoder = JSONDecoder()
                do {
                    let categoryResponse = try decoder.decode(CategoryResponse.self, from: moyaResponse.data)
                    let categories: [String] = self.cocktailsCategoryLogic.cocktailCategories(categoryResponse: categoryResponse)
                    completion(categories, nil)
                }
                catch {
                    print("Error: did not receive any cocktail's categories")
                }
            case .failure(_): break
            }
        }
    }
}
