import UIKit

class TextFieldCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.contentView.addSubview(self.textField)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    lazy var textField: UITextField = {
        let view = UITextField()

        return view
    }()

    var item: BreakfastItem? {
        didSet {
            self.textField.text = String(self.item?.price ?? 0) ?? ""
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.textField.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
    }
}