import UIKit

protocol TextFieldCellDelegate: class {
    func textFieldCell(textFieldCell: TextFieldCell, didUpdateText text: String)
}

class TextFieldCell: UITableViewCell {
    weak var delegate: TextFieldCellDelegate?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.selectionStyle = .None
        self.contentView.addSubview(self.textField)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    lazy var textField: UITextField = {
        let view = UITextField()
        view.font = UIFont.systemFontOfSize(19)
        view.addTarget(self, action: #selector(changedText), forControlEvents: .EditingChanged)

        return view
    }()

    var item: BreakfastItem? {
        didSet {
            self.textField.text = String(self.item?.price ?? 0) ?? ""
        }
    }

    func changedText(textField: UITextField) {
        self.delegate?.textFieldCell(self, didUpdateText: textField.text ?? "")
    }

    override func setHighlighted(highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)

        if highlighted {
            self.textField.becomeFirstResponder()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let parentWidth = self.frame.width
        let parentHeight = self.frame.height

        var textLabelFrame: CGRect {
            let horizontalMargin = CGFloat(20)
            let verticalMargin = CGFloat(20)
            let width = parentWidth - horizontalMargin * 2
            let height = parentHeight - verticalMargin * 2

            return CGRect(x: horizontalMargin, y: verticalMargin, width: width, height: height)
        }
        self.textField.frame = textLabelFrame
    }
}