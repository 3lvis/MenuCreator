import UIKit

extension UITableView {
    public func deselectCurrentlySelectedRow(animated: Bool = true) {
        if let selectedIndexPath = self.indexPathForSelectedRow {
            self.deselectRowAtIndexPath(selectedIndexPath, animated: animated)
        }
    }
}