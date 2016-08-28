import UIKit

class SwitchCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.textLabel?.text = NSLocalizedString("Is separator", comment: "")
        self.textLabel?.font = UIFont.boldSystemFontOfSize(19)

        self.contentView.addSubview(self.switchView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var switchView: UISwitch = {
        let view = UISwitch()

        return view
    }()

    var item: BreakfastItem? {
        didSet {
            self.switchView.on = self.item?.isSeparator ?? false
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()

        let parentWidth = self.frame.width
        let parentHeight = self.frame.height

        var switchViewFrame: CGRect {
            let horizontalMargin = CGFloat(20)
            let currentWidth = self.switchView.frame.width
            let currentHeight = self.switchView.frame.height
            let x = parentWidth - currentWidth - horizontalMargin
            let y = (parentHeight - currentHeight) / 2

            return CGRect(x: x, y: y, width: currentWidth, height: currentHeight)
        }
        self.switchView.frame = switchViewFrame
    }
}