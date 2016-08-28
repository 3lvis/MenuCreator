import UIKit

protocol ItemControllerDelegate: class {
    func itemController(itemController: ItemController, didRequestToSaveItem: BreakfastItem)
    func itemControllerDidCancel(itemController: ItemController)
}

class ItemController: UITableViewController {
    weak var controllerDelegate: ItemControllerDelegate?
    var item: BreakfastItem

    init(item: BreakfastItem) {
        self.item = item

        super.init(style: .Grouped)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = NSLocalizedString("Editing", comment: "")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: #selector(save))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(cancel))
    }

    func save() {
        self.controllerDelegate?.itemController(self, didRequestToSaveItem: self.item)
    }

    func cancel() {
        self.controllerDelegate?.itemControllerDidCancel(self)
    }
}