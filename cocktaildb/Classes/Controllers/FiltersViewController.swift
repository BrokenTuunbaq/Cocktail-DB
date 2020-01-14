import UIKit

final class FiltersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var filtersTable: UITableView!
    @IBOutlet weak var filterApplyButton: UIButton!
    var counterDisableApplyButton = 0
    let filterLogic = FilterLogic()
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        filterApplyButton.isEnabled = false
        filtersTable.delegate = self
        filtersTable.dataSource = self
    }
    
    @IBAction func filterApplyPressed(_ sender: Any) {
        RuntimeStorage.filterCategories = RuntimeStorage.cocktailCategories
        for row: Int in 0..<RuntimeStorage.filterCategories!.count {
            let selectedRow: FilterCell = self.filtersTable.cellForRow(at: IndexPath(row: row, section: 0)) as! FilterCell
            if selectedRow.isFilterSelected == false {
                RuntimeStorage.filterCategories![row] = StringConstants.EMPTY_STRING
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RuntimeStorage.cocktailCategories!.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rowSelectedDeselected(indexPath: indexPath, tableView: tableView)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        rowSelectedDeselected(indexPath: indexPath, tableView: tableView)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath) as! FilterCell
        cell.filterNameLabel.text = RuntimeStorage.cocktailCategories![indexPath.row]
        cell.isFilterSelected = filterLogic.selectionByFilter(selection: RuntimeStorage.filterCategories![indexPath.row])
        cell.cellCheckFilter()
        return cell
    }
}

extension FiltersViewController {
    
    /// Returns if filter apply button must be enabled/disabled after filter selection/deselection
    /// - Parameters:
    ///   - cellIndex: index of selected row
    ///   - tableView: table
    func isEnableApplyButton(cellIndex: IndexPath, tableView: UITableView) -> Bool {
        let cell = tableView.cellForRow(at: cellIndex) as! FilterCell
        let filterIndex = cellIndex.row
        if cell.isFilterSelected == true && RuntimeStorage.filterCategories![filterIndex] == StringConstants.EMPTY_STRING || cell.isFilterSelected == false && RuntimeStorage.filterCategories![filterIndex] != StringConstants.EMPTY_STRING {
            counterDisableApplyButton += 1
        } else {
            counterDisableApplyButton -= 1
        }
        if counterDisableApplyButton > 0 {
            return true
        } else {
            return false
        }
    }
    
    /// Logic of selection/deselection of a filter
    /// - Parameters:
    ///   - indexPath: selected row
    ///   - tableView: tableView
    func rowSelectedDeselected(indexPath: IndexPath, tableView: UITableView) {
        let selectedCell = tableView.cellForRow(at: indexPath) as! FilterCell
        selectedCell.isFilterSelected = selectedCell.selectionSwitch()
        selectedCell.cellCheckFilter()
        filterApplyButton.isEnabled = isEnableApplyButton(cellIndex: indexPath, tableView: tableView)
    }
}
