import Foundation

/// Helping methods for filters' performing, displaying and selection
struct FilterLogic {

    func sectionNameByFilter(filterCategories: [String], notEmptyCounter: Int) -> String {
        var counterForCategory = 0
        for category in filterCategories {
            if !category.isEmpty {
                if counterForCategory != notEmptyCounter {
                    counterForCategory += 1
                } else {
                    return category
                }
            }
        }
        return StringConstants.EMPTY_STRING
    }
    
    func sectionCountFilter(filterCategories: [String]) -> Int {
        var counterForCategory = 0
        for category in filterCategories {
            if !category.isEmpty {
                counterForCategory += 1
            }
        }
        return counterForCategory
    }
    
    func selectionByFilter(selection: String) -> Bool {
        if selection.isEmpty {
            return false
        }
        return true
    }
    
    func filterImageName(categories: [String]?, filters: [String]?) -> String {
        if categories == filters {
            return StringConstants.FILTER_ICON
        }
        return StringConstants.FILTER_ICON_DOT
    }
}
