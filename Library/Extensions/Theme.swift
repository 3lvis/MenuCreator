import UIKit

extension UIColor {
    class func customColor() -> UIColor {
        return UIColor.redColor()
    }
}

extension UIFont {
    class func regular(size: Double) -> UIFont {
        return UIFont(name: "CustomFont-Regular", size: CGFloat(size))!
    }
}
