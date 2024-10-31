import SpriteKit

class DevelopmentNode: SKNode {
    var zodiacManagerNode: ZodiacManagerNode?
    var gameRoleLabelManagerNode: GameRoleLabelManagerNode?
    fileprivate var spinnyNode: SKShapeNode?

    // 保存 availableWidth 和 availableHeight
    private var availableWidth: CGFloat = 0.0
    private var availableHeight: CGFloat = 0.0

    func setupNodes(availableWidth: CGFloat, availableHeight: CGFloat) {
        self.availableWidth = availableWidth
        self.availableHeight = availableHeight

        zodiacManagerNode = ZodiacManagerNode()
        guard let zodiacManagerNode = zodiacManagerNode else { return }

        zodiacManagerNode.setupZodiacNodes(
            availableWidth: availableWidth * 0.8, availableHeight: availableHeight * 0.8)
        self.addChild(zodiacManagerNode)

        gameRoleLabelManagerNode = GameRoleLabelManagerNode()
        guard let gameRoleLabelManagerNode = gameRoleLabelManagerNode else { return }

        gameRoleLabelManagerNode.setupPlayerRoleLabels(
            players: GameDataCenter.shared.players,
            adjustedSize: CGSize(width: availableWidth, height: availableHeight))
        self.addChild(gameRoleLabelManagerNode)

        // 設置旋轉節點
        let w = (availableWidth + availableHeight) * 0.05
        self.spinnyNode = SKShapeNode(
            rectOf: CGSize(width: w, height: w), cornerRadius: w * 0.3)

        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 4.0
            spinnyNode.run(
                SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(
                SKAction.sequence([
                    SKAction.wait(forDuration: 0.5),
                    SKAction.fadeOut(withDuration: 0.5),
                    SKAction.removeFromParent(),
                ]))
        }
    }

    func assignRolesToPlayers() {
        var roles: [GameRole] = [
            .appraiser, .appraiser, .forger, .forger, .appraiser, .appraiser, .forger, .forger,
        ]
        roles.shuffle()

        for i in 0..<GameDataCenter.shared.players.count {
            GameDataCenter.shared.players[i].role = roles[i % roles.count]
        }

        displayPlayerRoles()
    }

    func displayPlayerRoles() {
        guard let gameRoleLabelManagerNode = gameRoleLabelManagerNode else {
            print("Error: gameRoleLabelManagerNode is nil")
            return
        }

        gameRoleLabelManagerNode.setupPlayerRoleLabels(
            players: GameDataCenter.shared.players,
            adjustedSize: CGSize(width: availableWidth, height: availableHeight))
    }

    /// 創建旋轉節點
    func makeSpinny(at pos: CGPoint, color: SKColor) {
        if let spinny = self.spinnyNode?.copy() as! SKShapeNode? {
            // 將坐標轉換為 SKScene 上的坐標
            if let scene = self.scene {
                spinny.position = pos
                spinny.strokeColor = color
                scene.addChild(spinny)
            }
        }
    }
}
