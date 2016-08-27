import UIKit

class ListController: UITableViewController {
    let data = BreakfastItem.generateData()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return data.keys.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.objectsForSection(section).count
    }

    func objectsForSection(section: Int) -> [BreakfastItem] {
        switch section {
        case 0:
            return data[BreakfastItem.GroupType.platosListos.rawValue] ?? [BreakfastItem]()
        case 1:
            return data[BreakfastItem.GroupType.desayuno.rawValue] ?? [BreakfastItem]()
        case 2:
            return data[BreakfastItem.GroupType.sandwichs.rawValue] ?? [BreakfastItem]()
        case 3:
            return data[BreakfastItem.GroupType.jugos.rawValue] ?? [BreakfastItem]()
        default:
            return [BreakfastItem]()
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let items = self.objectsForSection(indexPath.section)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.title

        return cell
    }
}
