import Foundation
import Moya

//Definition of network API methods
extension CocktailAPI: TargetType {
    var baseURL: URL { return URL(string: StringConstants.BASE_URL)! }
    var path: String {
        switch self {
        case .categories:
            return StringConstants.CATEGORIES_PATH
        case .cocktailsByCategory(_):
            return StringConstants.COCKTAILS_PATH
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .categories, .cocktailsByCategory(_):
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .categories:
            return .requestParameters(
            parameters: ["c": "list"],
            encoding: URLEncoding.default)
        case .cocktailsByCategory(let categoryName):
            return .requestParameters(
            parameters: ["c": categoryName],
            encoding: URLEncoding.default)
        }
    }
    
    var sampleData: Data {
        switch self {
        case .categories, .cocktailsByCategory(_):
            return StringConstants.EMPTY_STRING.utf8Encoded
        }
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
