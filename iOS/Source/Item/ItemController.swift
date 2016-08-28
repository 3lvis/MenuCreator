import UIKit

protocol ItemControllerDelegate: class {
    func itemController(itemController: ItemController, didRequestToUpdateItem: BreakfastItem)
    func itemController(itemController: ItemController, didRequestToCreateItem: BreakfastItem)
    func itemControllerDidCancel(itemController: ItemController)
}

class ItemController: UITableViewController {
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