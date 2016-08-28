import UIKit

class ListController: UITableViewController {
    let data = BreakfastItem.generateData()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.registerClass(SectionHeaderView.self, forHeaderFooterViewReuseIdentifier: "Header")
        self.tableView.register(ItemCell)
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

    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterViewWithIdentifier("Header") as? SectionHeaderView
        view?.groupType = BreakfastItem.groupTypeForSection(section)
        view?.delegate = self

        return view
    }
}

extension ListController: SectionHeaderViewDelegate {
    func sectionHeaderView(sectionHeaderView: SectionHeaderView, didTappedAddButtonForGroupType groupType: BreakfastItem.GroupType) {
        print("add: \(groupType.rawValue)")
    }
}
