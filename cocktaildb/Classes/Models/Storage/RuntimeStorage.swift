import Foundation

/// Global static storage for categories and filters
struct RuntimeStorage {
    
    static var cocktailCategories: [String]?
    static var filterCategories: [String]?
    
    static func initFilterCategories() {
        guard RuntimeStorage.cocktailCategories!.count > 0 else {
            return
        }
        if RuntimeStorage.filterCategories == nil {
            RuntimeStorage.filterCategories = [String]()
            RuntimeStorage.filterCategories = RuntimeStorage.cocktailCategories
        }
    }
}
