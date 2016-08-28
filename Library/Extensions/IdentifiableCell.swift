import UIKit

public protocol Identifiable {
    static var reuseIdentifier: String { get }
}

public extension Identifiable {
    public static var reuseIdentifier: String {
        get {
            return String(self)
        }
    }
}

extension UITableViewCell: Identifiable {

}

extension UICollectionViewCell: Identifiable {

}

extension UITableViewHeaderFooterView: Identifiable {

}

public extension UITableView {
    public func register(cellClass: UITableViewCell.Type) {
        self.registerClass(cellClass.self, forCellReuseIdentifier: cellClass.reuseIdentifier)
    }

    public func registerHeaderFooter(viewClass: UITableViewHeaderFooterView.Type) {
        self.registerClass(viewClass.self, forHeaderFooterViewReuseIdentifier: viewClass.reuseIdentifier)
    }
}

public extension UICollectionView {
    public func register(cellClass: UICollectionViewCell.Type) {
        self.registerClass(cellClass.self, forCellWithReuseIdentifier: cellClass.reuseIdentifier)
    }
}