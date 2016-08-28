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

        return view
    }()

    var item: BreakfastItem? {
        didSet {
            self.textView.text = item?.title
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.textView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
    }
}