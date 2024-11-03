import SpriteKit

class ComponentFactory {
    static var componentsConfig: [[String: Any]] = []

    static func loadComponentsConfig() {
        if let path = Bundle.main.path(forResource: "componentsConfig", ofType: "json") {
            print("JSON path: \(path)")

            if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                print("Data successfully loaded from path")

                if let json = try? JSONSerialization.jsonObject(with: data, options: [])
                    as? [String: Any]
                {
                    print("JSON successfully parsed")

                    if let components = json["components"] as? [[String: Any]] {
                        componentsConfig = components
                        print("Components loaded: \(componentsConfig.count) items")
                    } else {
                        print("Failed to parse components from JSON")
                    }
                } else {
                    print("Failed to parse JSON data")
                }
            } else {
                print("Failed to load data from path")
            }
        } else {
            print("Failed to find path for componentsConfig.json")
        }
    }

    static func createComponent(named name: String) -> SKNode? {
        print("Attempting to create component named: \(name)")

        guard let config = componentsConfig.first(where: { $0["name"] as? String == name }) else {
            print("No component found with name: \(name)")
            return nil
        }

        print("Found configuration for component: \(config)")
        return createComponent(from: config)
    }

    static func createComponent(from config: [String: Any]) -> SKNode? {
        guard let type = config["type"] as? String else { return nil }

        switch type {
        case "label":
            return createLabel(from: config)
        case "button":
            return createButton(from: config)
        case "textfield":
            return createTextField(from: config)
        case "image":
            return createImage(from: config)
        default:
            return nil
        }
    }

    private static func createLabel(from config: [String: Any]) -> OutlinedLabelNode {
        let text = config["text"] as? String ?? ""
        let fontSize = config["fontSize"] as? CGFloat ?? 14
        let fontColor = UIColor(named: config["fontColor"] as? String ?? "black") ?? .black
        let outlineColor = UIColor(named: config["outlineColor"] as? String ?? "clear") ?? .clear
        let outlineWidth = config["outlineWidth"] as? CGFloat ?? 0

        let label = OutlinedLabelNode(
            text: text,
            fontSize: fontSize,
            fontColor: fontColor,
            outlineColor: outlineColor,
            outlineWidth: outlineWidth
        )
        return label
    }

    private static func createButton(from config: [String: Any]) -> RoundedButton {
        let text = config["text"] as? String ?? ""
        let width = config["width"] as? CGFloat ?? 100
        let height = config["height"] as? CGFloat ?? 50
        let fontSize = config["fontSize"] as? CGFloat ?? 14
        let normalColor = UIColor(named: config["normalColor"] as? String ?? "gray") ?? .gray
        let darkColor = UIColor(named: config["darkColor"] as? String ?? "darkGray") ?? .darkGray

        let button = RoundedButton(
            text: text,
            width: width,
            height: height,
            fontSize: fontSize,
            normalColor: normalColor,
            darkColor: darkColor
        )
        return button
    }

    private static func createTextField(from config: [String: Any]) -> SKTextFieldNode {
        let placeholder = config["placeholder"] as? String ?? ""
        let fontSize = config["fontSize"] as? CGFloat ?? 14
        // let fontColor = UIColor(named: config["fontColor"] as? String ?? "black") ?? .black
        // let backgroundColor =
        //     UIColor(named: config["backgroundColor"] as? String ?? "white") ?? .white

        // 自動對應常用顏色
        let fontColor: UIColor
        switch config["fontColor"] as? String ?? "black" {
        case "white":
            fontColor = .white
        case "black":
            fontColor = .black
        case "gray":
            fontColor = .gray
        default:
            fontColor = .black  // 預設顏色
        }

        let backgroundColor: UIColor
        switch config["backgroundColor"] as? String ?? "white" {
        case "white":
            backgroundColor = .white
        case "gray":
            backgroundColor = .gray
        default:
            backgroundColor = .white  // 預設顏色
        }

        let textField = SKTextFieldNode(
            placeholder: placeholder,
            fontSize: fontSize,
            fontColor: fontColor,
            backgroundColor: backgroundColor
        )
        return textField
    }

    private static func createImage(from config: [String: Any]) -> SKSpriteNode {
        let imageName = config["imageName"] as? String ?? ""
        let width = config["width"] as? CGFloat ?? 100
        let height = config["height"] as? CGFloat ?? 100

        let imageNode = SKSpriteNode(imageNamed: imageName)
        imageNode.size = CGSize(width: width, height: height)
        return imageNode
    }
}
