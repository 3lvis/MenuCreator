import Foundation
import UIKit

struct BreakfastItem {
    enum GroupType: String {
        case platosListos = "PLATOS LISTOS"
        case desayuno = "DESAYUNO"
        case sandwichs = "SANDWICHS"
        case jugos = "JUGOS"

        func section() -> Int {
            switch self {
            case .platosListos:
                return 0
            case .desayuno:
                return 1
            case .sandwichs:
                return 2
            case .jugos:
                return 3
            }
        }
    }

    static func groupTypeForSection(section: Int) -> BreakfastItem.GroupType {
        switch section {
        case 0:
            return BreakfastItem.GroupType.platosListos
        case 1:
            return BreakfastItem.GroupType.desayuno
        case 2:
            return BreakfastItem.GroupType.sandwichs
        case 3:
            return BreakfastItem.GroupType.jugos
        default:
            fatalError()
        }
    }

    var title: String
    var price: Double
    var isSeparator: Bool

    static func generateData() -> [String : [BreakfastItem]] {
        var items = [String : [BreakfastItem]]()

        let platosListosPath = NSBundle.mainBundle().pathForResource("desayuno-platos-listos", ofType: "plist")!
        let importedPlatosListos = NSArray(contentsOfFile: platosListosPath) as? [[String : AnyObject]] ?? [[String : AnyObject]]()
        var platosListos = [BreakfastItem]()
        for dictionary in importedPlatosListos {
            guard let title = dictionary["title"] as? String else { continue }
            guard let price = dictionary["price"] as? Double else { continue }

            let item = BreakfastItem(title: title, price: price, isSeparator: false)
            platosListos.append(item)
        }
        items[BreakfastItem.GroupType.platosListos.rawValue] = platosListos

        let item = BreakfastItem(title: "- TÉ ó MATE ó CHICHA\n- BROCOLY SALTADO\n- PAN", price: 7, isSeparator: false)
        items[BreakfastItem.GroupType.desayuno.rawValue] = [item]

        let sandwichsPath = NSBundle.mainBundle().pathForResource("sandwichs", ofType: "plist")!
        let importedSandwichs = NSArray(contentsOfFile: sandwichsPath) as? [[String : AnyObject]] ?? [[String : AnyObject]]()
        var sandwichs = [BreakfastItem]()
        for dictionary in importedSandwichs {
            guard let title = dictionary["title"] as? String else { continue }
            guard let price = dictionary["price"] as? Double else { continue }

            let item = BreakfastItem(title: title, price: price, isSeparator: false)
            sandwichs.append(item)
        }
        items[BreakfastItem.GroupType.sandwichs.rawValue] = sandwichs

        let jugosPath = NSBundle.mainBundle().pathForResource("jugos", ofType: "plist")!
        let importedJugos = NSArray(contentsOfFile: jugosPath) as? [[String : AnyObject]] ?? [[String : AnyObject]]()
        var jugos = [BreakfastItem]()
        for dictionary in importedJugos {
            guard let title = dictionary["title"] as? String else { continue }
            guard let price = dictionary["price"] as? Double else { continue }

            let item = BreakfastItem(title: title, price: price, isSeparator: false)
            jugos.append(item)
        }
        items[BreakfastItem.GroupType.jugos.rawValue] = jugos

        return items
    }

    func height(forWidth width: CGFloat) -> CGFloat {
        let attributes = [NSFontAttributeName : ItemCell.titleLabelFont]
        let boundingRect = (self.title as NSString).boundingRectWithSize(CGSize(width: width, height: CGFloat.max), options: .UsesLineFragmentOrigin, attributes: attributes, context: nil)

        return boundingRect.height
    }

    static func objectsForSection(data: [String : [BreakfastItem]], section: Int) -> [BreakfastItem] {
        let groupType = BreakfastItem.groupTypeForSection(section)

        return data[groupType.rawValue] ?? [BreakfastItem]()
    }

    static func itemAtIndexPath(data: [String : [BreakfastItem]], indexPath: NSIndexPath) -> BreakfastItem {
        let items = self.objectsForSection(data, section: indexPath.section)

        return items[indexPath.row]
    }
}