import SpriteKit

/// 管理遊戲首頁 UI 元素的節點
class GameHomeNode: SKNode {
    var playerImageNode: SKSpriteNode?
    var playerNameLabel: OutlinedLabelNode?
    var enterButton: ButtonNode?
    var startButton: ButtonNode?
    var settingsButton: ButtonNode?

    // 保存 availableWidth 和 availableHeight
    private var availableWidth: CGFloat = 0.0
    private var availableHeight: CGFloat = 0.0

    /// 設置 GameHomeNode 的各個子節點
    func setupNodes(availableWidth: CGFloat, availableHeight: CGFloat) {
        self.availableWidth = availableWidth
        self.availableHeight = availableHeight

        // Setup player image
        playerImageNode = SKSpriteNode(imageNamed: "logoImage")
        guard let playerImageNode = playerImageNode else { return }
        playerImageNode.size = CGSize(width: 256, height: 256)

        // Setup player name label
        playerNameLabel = OutlinedLabelNode(
            text: "玩家姓名",
            fontSize: 48,
            fontColor: .white,
            outlineColor: .black,
            outlineWidth: 2
        )
        guard let playerNameLabel = playerNameLabel else { return }

        // Arrange player image and name label horizontally
        let topHStack = HStackNode(containerWidth: availableWidth)
        topHStack.addElement(playerImageNode)
        topHStack.addElement(playerNameLabel)
        topHStack.position = CGPoint(x: 0, y: availableHeight / 2 - 120)
        self.addChild(topHStack)

        // Setup enter button
        enterButton = ButtonNode()
        guard let enterButton = enterButton else { return }
        enterButton.size = CGSize(width: 200, height: 50)

        // Setup start button
        startButton = ButtonNode()
        guard let startButton = startButton else { return }
        startButton.size = CGSize(width: 200, height: 50)

        // Arrange enter and start buttons vertically
        let middleVStack = VStackNode(containerHeight: availableHeight / 2)
        middleVStack.addElement(enterButton)
        middleVStack.addElement(startButton)
        middleVStack.position = CGPoint(x: 0, y: 0)
        self.addChild(middleVStack)

        // Setup settings button
        settingsButton = ButtonNode()
        guard let settingsButton = settingsButton else { return }
        settingsButton.size = CGSize(width: 100, height: 50)

        // Arrange settings button horizontally
        let bottomHStack = HStackNode(containerWidth: availableWidth)
        bottomHStack.addElement(settingsButton)
        bottomHStack.position = CGPoint(x: 0, y: -availableHeight / 2 + 100)
        self.addChild(bottomHStack)
    }

    // Additional methods for button actions can be added here
}
