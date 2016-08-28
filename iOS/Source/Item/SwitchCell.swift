import UIKit

class SwitchCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.textLabel?.text = NSLocalizedString("Is separator", comment: "")
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

        self.switchView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
    }
}