import UIKit

class ItemsController: UITableViewController {
    let data = BreakfastItem.generateData()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = NSLocalizedString("Breakfast", comment: "")
        self.tableView.registerClass(SectionHeaderView.self, forHeaderFooterViewReuseIdentifier: "Header")
        self.tableView.register(ItemCell)
        self.tableView.registerHeaderFooter(SectionHeaderView)
        self.tableView.cellLayoutMarginsFollowReadableWidth = false
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.data.keys.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.objectsForSection(section).count
    }

    func objectsForSection(section: Int) -> [BreakfastItem] {
        let groupType = BreakfastItem.groupTypeForSection(section)

        return self.data[groupType.rawValue] ?? [BreakfastItem]()
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(ItemCell.reuseIdentifier, forIndexPath: indexPath) as! ItemCell
        let items = self.objectsForSection(indexPath.section)
        cell.item = items[indexPath.row]

        return cell
    }

    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
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
        let items = self.objectsForSection(indexPath.section)
        let item = items[indexPath.row]
        let controller = ItemController(item: item)
        controller.controllerDelegate = self
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.modalPresentationStyle = .FormSheet
        self.presentViewController(navigationController, animated: true, completion: nil)
    }
}

extension ItemsController: SectionHeaderViewDelegate {
    func sectionHeaderView(sectionHeaderView: SectionHeaderView, didTappedAddButtonForGroupType groupType: BreakfastItem.GroupType) {
        print("add: \(groupType.rawValue)")
    }
}

extension ItemsController: ItemControllerDelegate {
    func itemController(itemController: ItemController, didRequestToSaveItem: BreakfastItem) {
        self.dismissViewControllerAnimated(true) {
            self.tableView.deselectCurrentlySelectedRow()
        }
    }

    func itemControllerDidCancel(itemController: ItemController) {
        self.dismissViewControllerAnimated(true) {
            self.tableView.deselectCurrentlySelectedRow()
        }
    }
}