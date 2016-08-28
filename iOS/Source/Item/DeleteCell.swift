import UIKit

class DeleteCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.textLabel?.textColor = UIColor.redColor()
        self.textLabel?.font = UIFont.boldSystemFontOfSize(19)
        self.textLabel?.text = NSLocalizedString("Delete", comment: "")
        self.textLabel?.textAlignment = .Center
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}