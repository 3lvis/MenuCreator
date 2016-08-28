import UIKit

protocol SectionHeaderViewDelegate: class {
    func sectionHeaderView(sectionHeaderView: SectionHeaderView, didTappedAddButtonForGroupType groupType: BreakfastItem.GroupType)
}

class SectionHeaderView: UITableViewHeaderFooterView {
    static let height = CGFloat(50)

    weak var delegate: SectionHeaderViewDelegate?

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFontOfSize(17)
        label.textColor = UIColor(red: 0, green: 122.0/255.0, blue: 1, alpha: 1.0)

        return label
    }()

    lazy var addButton: UIButton = {
        let button = UIButton(type: .Custom)
        button.setImage(UIImage(named: "plus"), forState: .Normal)
        button.addTarget(self, action: #selector(SectionHeaderView.addButtonAction), forControlEvents: .TouchUpInside)

        return button
    }()

    var groupType = BreakfastItem.GroupType.platosListos {
        didSet {
            self.titleLabel.text = groupType.rawValue
            self.addButton.hidden = groupType == .desayuno
        }
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.addButton)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addButtonAction() {
        self.delegate?.sectionHeaderView(self, didTappedAddButtonForGroupType: self.groupType)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let parentWidth = self.frame.width
        let parentHeight =  self.frame.height

        let horizontalMargin = CGFloat(20)
        let width = parentWidth - (horizontalMargin * 2)

        var titleLabelFrame: CGRect {
            return CGRect(x: horizontalMargin, y: 0, width: width, height: parentHeight)
        }
        self.titleLabel.frame = titleLabelFrame

        var addButtonFrame: CGRect {
            let size = CGFloat(20)
            let x = parentWidth - (size * 2)
            let y = (parentHeight - size) / 2

            return CGRect(x: x, y: y, width: size, height: size)
        }
        self.addButton.frame = addButtonFrame
    }
}