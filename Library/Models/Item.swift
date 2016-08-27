import Foundation

enum PageType {
    case breakfast, lunch, dinner, others
}

protocol Item {
    var title: String { get }
    var price: Double { get }
    var isSeparator: Bool { get }
}

struct BreakfastItem: Item {
    enum Type {
        case platosListos, desayuno, sandwichs, jugos
    }

    let title: String
    let price: Double
    let isSeparator: Bool
    let type: Type

    static func generateData() -> [BreakfastItem] {
        var items = [BreakfastItem]()

        let platosListosPath = NSBundle.mainBundle().pathForResource("desayuno-platos-listos", ofType: "plist")!
        let platosListos = NSArray(contentsOfFile: platosListosPath) as? [[String : AnyObject]] ?? [[String : AnyObject]]()
        for dictionary in platosListos {
            guard let title = dictionary["title"] as? String else { continue }
            guard let price = dictionary["price"] as? Double else { continue }

            let item = BreakfastItem(title: title, price: price, isSeparator: false, type: .platosListos)
            items.append(item)
        }

        let item = BreakfastItem(title: "", price: 0, isSeparator: false, type: .desayuno)
        items.append(item)

        let sandwichsPath = NSBundle.mainBundle().pathForResource("sandwichs", ofType: "plist")!
        let sandwichs = NSArray(contentsOfFile: sandwichsPath) as? [[String : AnyObject]] ?? [[String : AnyObject]]()
        for dictionary in sandwichs {
            guard let title = dictionary["title"] as? String else { continue }
            guard let price = dictionary["price"] as? Double else { continue }

            let item = BreakfastItem(title: title, price: price, isSeparator: false, type: .sandwichs)
            items.append(item)
        }

        let jugosPath = NSBundle.mainBundle().pathForResource("jugos", ofType: "plist")!
        let jugos = NSArray(contentsOfFile: jugosPath) as? [[String : AnyObject]] ?? [[String : AnyObject]]()
        for dictionary in jugos {
            guard let title = dictionary["title"] as? String else { continue }
            guard let price = dictionary["price"] as? Double else { continue }

            let item = BreakfastItem(title: title, price: price, isSeparator: false, type: .jugos)
            items.append(item)
        }

        return items
    }
}