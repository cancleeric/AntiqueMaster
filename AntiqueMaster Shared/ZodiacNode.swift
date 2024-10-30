import SpriteKit

class ZodiacNode: SKSpriteNode {
    static let zodiacNames = [
        "Rat", "Ox", "Tiger", "Rabbit", "Dragon", "Snake", "Horse", "Goat", "Monkey", "Rooster",
        "Dog", "Pig",
    ]

    init(name: String, maxSize: CGSize) {
        let texture = SKTexture(imageNamed: name)
        super.init(texture: texture, color: .clear, size: texture.size())
        self.setScale(min(maxSize.width / self.size.width, maxSize.height / self.size.height))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
