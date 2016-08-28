import UIKit

protocol PreviewControllerDelegate: class {
    func previewControllerDidRequestForPrint(previewController: PreviewController)
    func previewControllerCancel(previewController: PreviewController)
}

class PreviewController: UIViewController {
    weak var delegate: PreviewControllerDelegate?

    let data: [String : [BreakfastItem]]

    init(data: [String : [BreakfastItem]]) {
        self.data = data

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = NSLocalizedString("Preview", comment: "")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(print))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Print", comment: ""), style: .Plain, target: self, action: #selector(done))
        self.view.backgroundColor = .whiteColor()
    }

    func print() {
        self.delegate?.previewControllerDidRequestForPrint(self)
    }

    func done() {
        self.delegate?.previewControllerCancel(self)
    }
}