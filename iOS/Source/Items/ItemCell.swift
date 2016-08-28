import UIKit

class ItemCell: UITableViewCell {
    static let baseHeight = CGFloat(60.0)
    static let titleLabelFont = UIFont.systemFontOfSize(19)
    static let subtitleLabelFont = UIFont.systemFontOfSize(19)

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Value1, reuseIdentifier: reuseIdentifier)

        self.accessoryType = .DisclosureIndicator

        self.textLabel?.numberOfLines = 0
        self.textLabel?.font = ItemCell.titleLabelFont

        self.detailTextLabel?.textAlignment = .Right
        self.detailTextLabel?.font = ItemCell.subtitleLabelFont
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var item: BreakfastItem? {
        didSet {
            self.textLabel?.text = item?.title
            if let price = item?.price {
                self.detailTextLabel?.text = String(price)
            } else {
                self.detailTextLabel?.text = ""
            }
        }
    }
}