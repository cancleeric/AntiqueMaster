import Foundation
import SpriteKit

class PrimeStackNode: SKSpriteNode {
    var padding: CGFloat
    var spacing: CGFloat

    init(size: CGSize = .zero, padding: CGFloat = 0, spacing: CGFloat = 0) {
        self.padding = padding
        self.spacing = spacing
        super.init(texture: nil, color: .clear, size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateWidth() {
        var maxWidth: CGFloat = 0
        for node in children {
            if node.frame.size.width > maxWidth {
                maxWidth = node.frame.size.width
            }
        }
        size.width = maxWidth
    }

    func updateHeight() {
        var totalHeight: CGFloat = padding * 2
        for node in children {
            totalHeight += node.frame.size.height + spacing
        }
        totalHeight -= spacing

        size.height = totalHeight
    }
}
