import Foundation

struct BreakfastItem {
    enum GroupType: String {
        case platosListos = "PLATOS LISTOS"
        case desayuno = "DESAYUNO"
        case sandwichs = "SANDWICHS"
        case jugos = "JUGOS"
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

    let title: String
    let price: Double
    let isSeparator: Bool

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

        let item = BreakfastItem(title: "", price: 0, isSeparator: false)
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
        items[BreakfastItem.GroupType.desayuno.rawValue] = sandwichs

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
}