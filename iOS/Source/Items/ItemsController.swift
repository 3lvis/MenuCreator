import UIKit

class ItemsController: UITableViewController {
    var data = BreakfastItem.generateData()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = NSLocalizedString("Breakfast", comment: "")
        self.tableView.registerClass(SectionHeaderView.self, forHeaderFooterViewReuseIdentifier: "Header")
        self.tableView.register(ItemCell)
        self.tableView.registerHeaderFooter(SectionHeaderView)
        self.tableView.cellLayoutMarginsFollowReadableWidth = false
        self.tableView.sectionHeaderHeight = SectionHeaderView.height
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.data.keys.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BreakfastItem.objectsForSection(self.data, section: section).count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(ItemCell.reuseIdentifier, forIndexPath: indexPath) as! ItemCell
        cell.item = BreakfastItem.itemAtIndexPath(self.data, indexPath: indexPath)

        return cell
    }

    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.layoutMargins = UIEdgeInsetsZero
        cell.separatorInset = UIEdgeInsetsZero
        cell.preservesSuperviewLayoutMargins = false
    }

    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterViewWithIdentifier(SectionHeaderView.reuseIdentifier) as! SectionHeaderView
        view.groupType = BreakfastItem.groupTypeForSection(section)
        view.delegate = self

        return view
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let item = BreakfastItem.itemAtIndexPath(self.data, indexPath: indexPath)
        let controller = ItemController(item: item)
        controller.controllerDelegate = self
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.modalPresentationStyle = .FormSheet
        self.presentViewController(navigationController, animated: true, completion: nil)
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let item = BreakfastItem.itemAtIndexPath(self.data, indexPath: indexPath)
        let verticalMargin = CGFloat(10)
        var height = item.height(forWidth: self.tableView.frame.width)
        height = height < ItemCell.baseHeight ? ItemCell.baseHeight : height + (verticalMargin * 2)

        return height
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        let groupType = BreakfastItem.groupTypeForSection(indexPath.section)
        return groupType != .desayuno
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {

        }
    }

    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        let groupType = BreakfastItem.groupTypeForSection(indexPath.section)
        return groupType != .desayuno
    }

    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
    }
}

extension ItemsController: SectionHeaderViewDelegate {
    func sectionHeaderView(sectionHeaderView: SectionHeaderView, didTappedAddButtonForGroupType groupType: BreakfastItem.GroupType) {
        let controller = ItemController(groupType: groupType)
        controller.controllerDelegate = self
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.modalPresentationStyle = .FormSheet
        self.presentViewController(navigationController, animated: true, completion: nil)
    }
}

extension ItemsController: ItemControllerDelegate {
    func itemController(itemController: ItemController, didRequestToUpdateItem item: BreakfastItem) {
        self.dismissViewControllerAnimated(true) {
            if let selectedIndexPath = self.tableView.indexPathForSelectedRow {
                let groupType = BreakfastItem.groupTypeForSection(selectedIndexPath.section)
                var objects = BreakfastItem.objectsForSection(self.data, section: selectedIndexPath.section)
                objects[selectedIndexPath.row] = item
                self.data[groupType.rawValue] = objects
                self.tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .Fade)
            }

            self.tableView.deselectCurrentlySelectedRow()
        }
    }

    func itemController(itemController: ItemController, didRequestToCreateItem item: BreakfastItem, groupType: BreakfastItem.GroupType) {
        self.dismissViewControllerAnimated(true) {
            if var objects = self.data[groupType.rawValue] {
                objects.append(item)
                self.data[groupType.rawValue] = objects
                let indexPath = NSIndexPath(forRow: objects.count - 1, inSection: groupType.section())
                self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
        }
    }

    func itemController(itemController: ItemController, didRequestToDeleteItem item: BreakfastItem) {
        self.dismissViewControllerAnimated(true) {
            if let selectedIndexPath = self.tableView.indexPathForSelectedRow {
                let groupType = BreakfastItem.groupTypeForSection(selectedIndexPath.section)
                var objects = BreakfastItem.objectsForSection(self.data, section: selectedIndexPath.section)
                objects.removeAtIndex(selectedIndexPath.row)
                self.data[groupType.rawValue] = objects
                self.tableView.deleteRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .Automatic)
            }
        }
    }

    func itemControllerDidCancel(itemController: ItemController) {
        self.dismissViewControllerAnimated(true) {
            self.tableView.deselectCurrentlySelectedRow()
        }
    }
}