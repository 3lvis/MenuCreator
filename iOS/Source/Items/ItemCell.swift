import UIKit

class ItemCell: UITableViewCell {
    static let baseHeight = CGFloat(60.0)
    static let titleLabelFont = UIFont.systemFontOfSize(19)
    static let subtitleLabelFont = UIFont.systemFontOfSize(19)

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.subtitleLabel)
        self.contentView.addSubview(self.arrowView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = ItemCell.titleLabelFont

        return label
    }()

    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .Right
        label.font = ItemCell.subtitleLabelFont

        return label
    }()

    lazy var arrowView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "arrow")

        return view
    }()

    var item: BreakfastItem? {
        didSet {
            self.titleLabel.text = item?.title
            if let price = item?.price {
                self.subtitleLabel.text = String(price)
            } else {
                self.subtitleLabel.text = ""
            }
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let parentWidth = self.frame.width
        let parentHeight =  self.frame.height
        self.contentView.frame = CGRect(x: 0, y: 0, width: parentWidth, height: parentHeight)

        let horizontalMargin = CGFloat(20)
        let boundsWidth = parentWidth - (horizontalMargin * 2)

        var titleLabelFrame: CGRect {
            let width = boundsWidth * 0.85
            return CGRect(x: horizontalMargin, y: 0, width: width, height: parentHeight)
        }
        self.titleLabel.frame = titleLabelFrame

        let accessoryWidth = self.arrowView.image?.size.width ?? 0

        var detailLabelFrame: CGRect {
            let width = boundsWidth * 0.13 - accessoryWidth
            let x = self.titleLabel.frame.maxX
            return CGRect(x: x, y: 0, width: width, height: parentHeight)
        }
        self.subtitleLabel.frame = detailLabelFrame

        var accessoryViewFrame: CGRect {
            let accessoryHeight = self.arrowView.image?.size.height ?? 0
            let rightMargin = CGFloat(15)
            let x = self.subtitleLabel.frame.maxX + rightMargin
            let y = (parentHeight - accessoryHeight) / 2
            return CGRect(x: x, y: y, width: accessoryWidth, height: accessoryHeight)
        }
        self.arrowView.frame = accessoryViewFrame
    }
}