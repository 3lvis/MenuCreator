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
        view.font = UIFont.systemFontOfSize(19)

        return view
    }()

    var item: BreakfastItem? {
        didSet {
            self.textField.text = String(self.item?.price ?? 0) ?? ""
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