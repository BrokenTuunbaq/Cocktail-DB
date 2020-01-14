import Foundation

extension DrinksViewController {
    
    //Network requests for DrinksViewController
    func requestCategories() {
        networkManager.categories {
            (categories, error) in
            if let error = error {
                print(error)
                return
            }
            RuntimeStorage.cocktailCategories = categories
            RuntimeStorage.initFilterCategories()
            self.requestCocktailsFirstCategory()
        }
    }
    
    func requestCocktailsFirstCategory() {
        for cocktailCategory in RuntimeStorage.filterCategories! {
            if !cocktailCategory.isEmpty {
                self.requestCocktails(categoryName: cocktailCategory)
                return
            }
        }
        hideHUD()
    }
    
    func requestCocktails(categoryName: String) {
        networkManager.cocktailsByCategory(categoryName: categoryName) {
            (cocktails, error) in
            if let error = error {
                print(error)
                return
            }
            guard let cocktails = cocktails else { return }
            self.fillCocktailsByCategory(cocktails: cocktails)
            self.setDelegateAndReloadCocktailsTable()
        }
    }
    
    func fillCocktailsByCategory(cocktails: [CocktailItem]) {
        if cocktailsByCategory == nil {
            cocktailsByCategory = [[CocktailItem]]()
        }
        cocktailsByCategory?.append(cocktails)
    }
}
