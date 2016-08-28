import UIKit

class ItemCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.contentView.addSubview(self.titleLabel)
        self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var titleLabel: UILabel = {
        let label = UILabel()

        return label
    }()

    var item: BreakfastItem? {
        didSet {
            self.titleLabel.text = item?.title
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let containerWidth = self.frame.width
        let containerHeight =  self.frame.height

        let horizontalMargin = CGFloat(20)
        let width = containerWidth - (horizontalMargin * 2)

        var titleLabelFrame: CGRect {
            return CGRect(x: horizontalMargin, y: 0, width: width, height: containerHeight)
        }
        self.titleLabel.frame = titleLabelFrame
    }
}