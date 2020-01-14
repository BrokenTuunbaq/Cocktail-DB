import Foundation

struct CocktailCategoryLogic {

    func cocktailCategories(categoryResponse: CategoryResponse) -> [String] {
        var cocktailCategories: [String]?
        cocktailCategories = [String]()
        for category in categoryResponse.drinks {
            cocktailCategories?.append(category.strCategory)
        }
        return cocktailCategories!
    }
}
