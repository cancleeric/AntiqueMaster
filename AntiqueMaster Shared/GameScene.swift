//
//  GameScene.swift
//  AntiqueMaster Shared
//
//  Created by EricWang on 2024/10/19.
//

import SpriteKit


protocol CustomFrameCalculable {
    /// 计算并返回节点的有效框架大小。
    /// 这应该是考虑到任何遮罩或其他条件后的可见区域的大小。
    var customFrame: CGRect { get }
}

/// `FrameSKNode` 是一個自訂的 SKNode 子類別，用來處理節點的邊框與大小
/// 當節點具有遮罩時，`calculateAccumulatedFrame` 可能無法正確取得節點的大小，因此需要小心處理。
class FrameSKNode: SKNode {
    
    /// 覆寫 frame 屬性，根據是否符合 `CustomFrameCalculable` 協定來決定回傳自訂的框架大小或是使用預設的計算方式。
    override var frame: CGRect {
        get {
            // 檢查當前物件是否符合 CustomFrameCalculable 協定
            if let selfCustomFrame = self as? CustomFrameCalculable {
                // 回傳自訂框架大小
                return selfCustomFrame.customFrame
            } else {
                // 若無遮罩則回傳累積計算的框架
                return self.calculateAccumulatedFrame()
            }
        }
    }
    
    /// 顯示節點的邊框，預設顏色為紅色`
    /// - Parameter color: 邊框顏色，預設為紅色
    func showBorder(color: UIColor = .red) {
        // 使用當前節點的大小來建立邊框節點
        addChild(BorderedNode(size: self.frame.size, borderColor: color))
    }
}


class GameSceneNode: FrameSKNode {

    /// 新建一個 `size` 成員來存儲計算後的大小
    var adjustedSize: CGSize = .zero

    /// 設置 GameSceneNode 的大小，去除安全區域後的可用區域
    func setupSize(for scene: SKScene) {
        // 獲取 SafeAreaManager 提供的安全區域內的可用寬度和高度
        let usableWidth = SafeAreaManager.shared.availableWidth
        let usableHeight = SafeAreaManager.shared.availableHeight

        // 計算去除安全區域後的可用區域尺寸
        let safeAreaInsets = SafeAreaManager.shared.safeAreaInsets
        let safeAreaInsetsWidth = safeAreaInsets.left + safeAreaInsets.right
        let safeAreaInsetsHeight = safeAreaInsets.top + safeAreaInsets.bottom
        adjustedSize = CGSize(width: scene.size.width - safeAreaInsetsWidth,
                              height: scene.size.height - safeAreaInsetsHeight)

        // 設置 GameSceneNode 的位置，使其在場景中居中顯示
//        self.position = CGPoint(x: scene.size.width / 2, y: scene.size.height / 2)
        
        // 將 GameSceneNode 的範圍設置為計算後的大小
        self.calculateNodeBounds(for: adjustedSize)
        
        
        // 計算畫面上可用的寬度和高度
        let availableWidth = adjustedSize.width * 0.8 //self.size.width * 0.8  // 使用螢幕寬度的 80%
        let availableHeight = adjustedSize.height * 0.8 //self.size.height * 0.8  // 使用螢幕高度的 80%

        // 設定元件數：每排3個，每列4排
        let itemsPerRow = 3
        let itemsPerColumn = 4

        // 假設每個銅像之間有固定的水平和垂直間距
        let horizontalSpacing: CGFloat = 20
        let verticalSpacing: CGFloat = 20

        // 計算每個元件可顯示的最大寬度和高度
        let maxItemWidth =
            (availableWidth - CGFloat(itemsPerRow - 1) * horizontalSpacing) / CGFloat(itemsPerRow)
        let maxItemHeight =
            (availableHeight - CGFloat(itemsPerColumn - 1) * verticalSpacing)
            / CGFloat(itemsPerColumn)

        // 使用 VStack 和 HStack 來佈局縮放後的圖片
        layoutStatuesInGrid(
            availableWidth: availableWidth,
            availableHeight: availableHeight,
            itemsPerRow: itemsPerRow,
            itemsPerColumn: itemsPerColumn,
            maxItemSize: CGSize(width: maxItemWidth, height: maxItemHeight),
            horizontalSpacing: horizontalSpacing,
            verticalSpacing: verticalSpacing)
    }

    /// 計算並設置節點的邊界
    private func calculateNodeBounds(for size: CGSize) {
        // 可以在這裡添加任何設置邊界或背景的邏輯，例如添加一個邊界框
        let boundary = SKShapeNode(rectOf: size)
        boundary.strokeColor = .blue // 邊界顏色可自定義
        boundary.lineWidth = 2
        self.addChild(boundary)
    }

    /// 添加子節點至 GameSceneNode
    func addGameNode(_ node: SKNode) {
        self.addChild(node)
    }
    
    
    private func layoutStatuesInGrid(
        availableWidth: CGFloat, availableHeight: CGFloat,
        itemsPerRow: Int, itemsPerColumn: Int,
        maxItemSize: CGSize, horizontalSpacing: CGFloat, verticalSpacing: CGFloat
    ) {
        
//        guard let gameSceneNode = gameSceneNode else { return }
        // 創建 VStackNode，負責垂直排列
        let vStack = VStackNode(containerHeight: availableHeight)
//        vStack.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)  // 放在螢幕中央
        self.addChild(vStack)
//        gameSceneNode.addChild(vStack)

        // 所有生肖銅像的名稱
        let zodiacNames = [
            "Rat", "Ox", "Tiger", "Rabbit", "Dragon", "Snake", "Horse", "Goat", "Monkey", "Rooster",
            "Dog", "Pig",
        ]

        // 排列圖像
        for row in 0..<itemsPerColumn {
            let hStack = HStackNode(containerWidth: availableWidth)  // 每一排的寬度

            for column in 0..<itemsPerRow {
                let index = row * itemsPerRow + column
                if index < zodiacNames.count {
                    let statue = ScaledSpriteNode(
                        imageNamed: zodiacNames[index], maxSize: maxItemSize)
                    hStack.addElement(statue)  // 添加到 HStackNode
                }
            }

            // 將每一排 (HStack) 添加到 VStack 中
            vStack.addElement(hStack)
        }
    }

}


class GameScene: GridScene {
    
    var gameSceneNode: GameSceneNode?
    

    fileprivate var label: SKLabelNode?
    fileprivate var spinnyNode: SKShapeNode?

    class func newGameScene() -> GameScene {
        // Load 'GameScene.sks' as an SKScene.
        guard let scene = SKScene(fileNamed: "GameScene") as? GameScene else {
            print("Failed to load GameScene.sks")
            abort()
        }

        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill

        return scene
    }

    func setUpScene() {
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }

        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(
            rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)

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

    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        
        // 創建 GameSceneNode 並設置大小
          gameSceneNode = GameSceneNode()
        guard let gameSceneNode = gameSceneNode else { return }
        
        gameSceneNode.setupSize(for: self)
        //將 gameSceneNode 置中
        gameSceneNode.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        
          
//           將 GameSceneNode 添加到場景中
          self.addChild(gameSceneNode)
        
        self.setUpScene()
        self.backgroundColor = SKColor.white  // 設置背景顏色

    }

    func makeSpinny(at pos: CGPoint, color: SKColor) {
        if let spinny = self.spinnyNode?.copy() as! SKShapeNode? {
            spinny.position = pos
            spinny.strokeColor = color
            self.addChild(spinny)
        }
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

#if os(iOS) || os(tvOS)
    // Touch-based event handling
    extension GameScene {

        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            if let label = self.label {
                label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
            }

            for t in touches {
                self.makeSpinny(at: t.location(in: self), color: SKColor.green)
            }
        }

        override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            for t in touches {
                self.makeSpinny(at: t.location(in: self), color: SKColor.blue)
            }
        }

        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            for t in touches {
                self.makeSpinny(at: t.location(in: self), color: SKColor.red)
            }
        }

        override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
            for t in touches {
                self.makeSpinny(at: t.location(in: self), color: SKColor.red)
            }
        }

    }
#endif

#if os(OSX)
    // Mouse-based event handling
    extension GameScene {

        override func mouseDown(with event: NSEvent) {
            if let label = self.label {
                label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
            }
            self.makeSpinny(at: event.location(in: self), color: SKColor.green)
        }

        override func mouseDragged(with event: NSEvent) {
            self.makeSpinny(at: event.location(in: self), color: SKColor.blue)
        }

        override func mouseUp(with event: NSEvent) {
            self.makeSpinny(at: event.location(in: self), color: SKColor.red)
        }

    }
#endif
