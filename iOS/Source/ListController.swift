import UIKit

class ListController: UITableViewController {
    let data = BreakfastItem.generateData()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.registerClass(SectionHeaderView.self, forHeaderFooterViewReuseIdentifier: "Header")
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return data.keys.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.objectsForSection(section).count
    }

    func objectsForSection(section: Int) -> [BreakfastItem] {
        let groupType = self.groupTypeForSection(section)
        return data[groupType.rawValue] ?? [BreakfastItem]()
    }

    func groupTypeForSection(section: Int) -> BreakfastItem.GroupType {
        switch section {
        case 0:
            return BreakfastItem.GroupType.platosListos
        case 1:
            return BreakfastItem.GroupType.desayuno
        case 2:
            return BreakfastItem.GroupType.sandwichs
        case 3:
            return BreakfastItem.GroupType.jugos
        default:
            fatalError()
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let items = self.objectsForSection(indexPath.section)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.title

        return cell
    }

    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterViewWithIdentifier("Header") as? SectionHeaderView
        view?.groupType = self.groupTypeForSection(section)
        view?.delegate = self

        return view
    }
}

extension ListController: SectionHeaderViewDelegate {
    func sectionHeaderView(sectionHeaderView: SectionHeaderView, didTappedAddButtonForGroupType groupType: BreakfastItem.GroupType) {
        print("add: \(groupType.rawValue)")
    }
}
