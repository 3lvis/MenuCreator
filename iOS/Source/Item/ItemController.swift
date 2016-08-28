import UIKit

protocol ItemControllerDelegate: class {
    func itemController(itemController: ItemController, didRequestToUpdateItem item: BreakfastItem)
    func itemController(itemController: ItemController, didRequestToCreateItem item: BreakfastItem)
    func itemController(itemController: ItemController, didRequestToDeleteItem item: BreakfastItem)
    func itemControllerDidCancel(itemController: ItemController)
}

class ItemController: UITableViewController {
    static let titleCellHeight = CGFloat(150)
    static let cellHeight = CGFloat(60)

    enum Section: Int {
        case title, price, others, delete

        func toString() -> String? {
            switch self {
            case .title:
                return NSLocalizedString("Title", comment: "")
            case .price:
                return NSLocalizedString("Price", comment: "")
            case .others:
                return NSLocalizedString("Others", comment: "")
            case .delete:
                return nil
            }
        }
    }

    weak var controllerDelegate: ItemControllerDelegate?
    var item: BreakfastItem
    var isNewItem = false

    init(item: BreakfastItem) {
        self.item = item

        super.init(style: .Grouped)
    }

    init() {
        self.item = BreakfastItem(title: "", price: 0, isSeparator: false)
        self.isNewItem = true

        super.init(style: .Grouped)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = self.isNewItem ? NSLocalizedString("Creating", comment: "") : NSLocalizedString("Editing", comment: "")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: #selector(save))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(cancel))

        self.tableView.register(TextViewCell)
        self.tableView.register(TextFieldCell)
        self.tableView.register(SwitchCell)
        self.tableView.register(DeleteCell)
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.isNewItem ? ItemController.Section.count - 1 : ItemController.Section.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let sectionType = ItemController.Section(rawValue: indexPath.section)!
        switch sectionType {
        case .title:
            let cell = tableView.dequeueReusableCellWithIdentifier(TextViewCell.reuseIdentifier, forIndexPath: indexPath) as! TextViewCell
            cell.item = self.item
            cell.delegate = self

            return cell
        case .price:
            let cell = tableView.dequeueReusableCellWithIdentifier(TextFieldCell.reuseIdentifier, forIndexPath: indexPath) as! TextFieldCell
            cell.item = self.item
            cell.delegate = self

            return cell
        case .others:
            let cell = tableView.dequeueReusableCellWithIdentifier(SwitchCell.reuseIdentifier, forIndexPath: indexPath) as! SwitchCell
            cell.item = self.item
            cell.delegate = self

            return cell
        case .delete:
            let cell = tableView.dequeueReusableCellWithIdentifier(DeleteCell.reuseIdentifier, forIndexPath: indexPath) as! DeleteCell

            return cell
        }
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionType = ItemController.Section(rawValue: section)!

        return sectionType.toString()
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let sectionType = ItemController.Section(rawValue: indexPath.section)!
        if sectionType == .title {
            return ItemController.titleCellHeight
        } else {
            return ItemController.cellHeight
        }
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectCurrentlySelectedRow()

        let sectionType = ItemController.Section(rawValue: indexPath.section)!
        if sectionType == .delete {
            self.controllerDelegate?.itemController(self, didRequestToDeleteItem: self.item)
        }
    }

    func save() {
        if self.isNewItem {
            self.controllerDelegate?.itemController(self, didRequestToCreateItem: self.item)
        } else {
            self.controllerDelegate?.itemController(self, didRequestToUpdateItem: self.item)
        }
    }

    func cancel() {
        self.controllerDelegate?.itemControllerDidCancel(self)
    }
}

extension ItemController: SwitchCellDelegate {
    func switchCell(switchCell: SwitchCell, didUpdateSwitch isSeparator: Bool) {
        self.item.isSeparator = isSeparator
    }
}

extension ItemController: TextViewCellDelegate {
    func textViewCell(textViewCell: TextViewCell, didUpdateText text: String) {
        self.item.title = text
    }
}

extension ItemController: TextFieldCellDelegate {
    func textFieldCell(textFieldCell: TextFieldCell, didUpdateText text: String) {
        if let price = Double(text) {
            self.item.price = price
        } else {
            self.item.price = 0
        }
    }
}
