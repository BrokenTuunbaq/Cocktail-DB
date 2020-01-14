import UIKit

final class FilterCell: UITableViewCell {
    
    @IBOutlet weak var filterSelectionLabel: UILabel!
    @IBOutlet weak var filterNameLabel: UILabel!
    var isFilterSelected: Bool = true

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension FilterCell {
    
    func selectionSwitch() -> Bool {
        if isFilterSelected == true {
            return false
        } else {
            return true
        }
    }
    
    func cellCheckFilter() {
        if isFilterSelected == false {
            filterSelectionLabel.text = StringConstants.EMPTY_STRING
        } else {
            filterSelectionLabel.text = StringConstants.CHECKED_STRING
        }
    }
}
