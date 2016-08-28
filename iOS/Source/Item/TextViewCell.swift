import UIKit

class TextViewCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.contentView.addSubview(self.textView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var textView: UITextView = {
        let view = UITextView()
        view.font = UIFont.systemFontOfSize(19)
        let margin = CGFloat(20)
        view.textContainerInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)

        return view
    }()

    var item: BreakfastItem? {
        didSet {
            self.textView.text = item?.title
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let parentWidth = self.frame.width
        let parentHeight = self.frame.height
        self.textView.frame = CGRect(x: 0, y: 0, width: parentWidth, height: parentHeight)
    }
}