import SpriteKit

class LayoutManager {
    static func layoutComponents(from config: [String: Any], in parent: SKNode) {
        guard let layoutConfig = config["layout"] as? [String: Any],
            let type = layoutConfig["type"] as? String
        else { return }

        switch type {
        case "vstack":
            layoutVStack(from: layoutConfig, in: parent)
        case "hstack":
            layoutHStack(from: layoutConfig, in: parent)
        default:
            break
        }
    }

    private static func layoutVStack(from config: [String: Any], in parent: SKNode) {
        let spacing = config["spacing"] as? CGFloat ?? 0
        let padding = config["padding"] as? CGFloat ?? 0
        let elements = config["elements"] as? [[String: Any]] ?? []

        let vStack = VStackNode(
            containerHeight: parent.frame.height, spacing: spacing, padding: padding)

        for elementConfig in elements {
            if let elementType = elementConfig["type"] as? String {
                switch elementType {
                case "component":
                    if let name = elementConfig["name"] as? String {
                        if let component = ComponentFactory.createComponent(named: name) {
                            vStack.addElement(component)
                        }
                    }
                case "spacer":
                    vStack.addElement(SpacerNode())
                default:
                    break
                }
            }
        }

        parent.addChild(vStack)
    }

    private static func layoutHStack(from config: [String: Any], in parent: SKNode) {
        let spacing = config["spacing"] as? CGFloat ?? 0
        let padding = config["padding"] as? CGFloat ?? 0
        let elements = config["elements"] as? [[String: Any]] ?? []

        let hStack = HStackNode(
            containerWidth: parent.frame.width, spacing: spacing, padding: padding)

        for elementConfig in elements {
            if let elementType = elementConfig["type"] as? String {
                switch elementType {
                case "component":
                    if let name = elementConfig["name"] as? String {
                        if let component = ComponentFactory.createComponent(named: name) {
                            hStack.addElement(component)
                        }
                    }
                case "spacer":
                    hStack.addElement(SpacerNode())
                default:
                    break
                }
            }
        }

        parent.addChild(hStack)
    }
}
