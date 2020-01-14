import UIKit
import Moya
import SDWebImage
import MBProgressHUD

final class DrinksViewController: UITableViewController {
    
    let provider = MoyaProvider<CocktailAPI>()
    let networkManager = NetworkManager()
    
    /// stores the cocktails array by category
    var cocktailsByCategory: [[CocktailItem]]?
    let cocktailCategoryLogic = CocktailCategoryLogic()
    let filterLogic = FilterLogic()
    var currentCocktailCategory = 0
    
    /// enables the loading of the next category cocktails
    var isLoadNextCategory = true
    @IBOutlet var cocktailsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.showHudForTable(StringConstants.EMPTY_STRING)
        navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = rightBarButton()
        self.cocktailsByCategory = [[CocktailItem]]()
        requestCategories()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard RuntimeStorage.filterCategories != nil else { return 0 }
        return cocktailsByCategory!.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard cocktailsByCategory != nil && cocktailsByCategory!.count > section else { return 0 }
        return cocktailsByCategory![section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StringConstants.COCKTAIL_CELL, for: indexPath) as! CocktailCell
        let cocktails = cocktailsByCategory![indexPath.section]
        cell.cocktailImage.sd_setImage(with: URL(string: cocktails[indexPath.item].strDrinkThumb), placeholderImage: UIImage(named: StringConstants.PLACEHOLDER))
        cell.cocktailName.text = cocktails[indexPath.item].strDrink
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard RuntimeStorage.filterCategories != nil else { return StringConstants.EMPTY_STRING }
        let sectionName = filterLogic.sectionNameByFilter(filterCategories: RuntimeStorage.filterCategories!, notEmptyCounter: section)
        return sectionName
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if isNextCategoryReady(currentCellIndexPath: indexPath) {
            let nextCategoryName = filterLogic.sectionNameByFilter(filterCategories: RuntimeStorage.filterCategories!, notEmptyCounter: indexPath.section + 1)
            isLoadNextCategory = false
            self.requestCocktails(categoryName: nextCategoryName)
            currentCocktailCategory += 1
        }
    }
}

extension DrinksViewController {
    
    /// pressing the filter button shows a filters screen
    @objc func pressFilterButton() {
        performSegue(withIdentifier: StringConstants.FILTER_SEGUE, sender: nil)
    }
    
    func rightBarButton() -> UIBarButtonItem {
        let button = UIButton()
        button.setImage(UIImage(named: filterLogic.filterImageName(categories: RuntimeStorage.filterCategories, filters: RuntimeStorage.cocktailCategories)), for: .normal)
        button.addTarget(self, action: #selector(pressFilterButton), for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }
    
    func setDelegateAndReloadCocktailsTable() {
        DispatchQueue.main.async {
            self.cocktailsTable.delegate = self
            self.cocktailsTable.dataSource = self
            self.cocktailsTable.reloadData()
            self.hideHUD()
        }
        self.isLoadNextCategory = true
    }
    
    func isNextCategoryReady(currentCellIndexPath: IndexPath) -> Bool {
        if currentCellIndexPath.row >= 0 && isLoadNextCategory == true && currentCocktailCategory <= currentCellIndexPath.section && currentCellIndexPath.section < filterLogic.sectionCountFilter(filterCategories: RuntimeStorage.filterCategories!) - 1 {
            return true
        } else { return false }
    }
}
