//
//  GameScene.swift
//  AntiqueMaster Shared
//
//  Created by EricWang on 2024/10/19.
//

import SpriteKit

class GameScene: SKScene {
    
    
    fileprivate var label : SKLabelNode?
    fileprivate var spinnyNode : SKShapeNode?

    
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
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 4.0
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
    }
    
    override func didMove(to view: SKView) {
        self.setUpScene()
        self.backgroundColor = SKColor.white // 設置背景顏色


        // 計算畫面上可用的寬度和高度
        let availableWidth = self.size.width * 0.8  // 使用螢幕寬度的 80%
        let availableHeight = self.size.height * 0.8 // 使用螢幕高度的 80%

        // 設定元件數：每排3個，每列4排
        let itemsPerRow = 3
        let itemsPerColumn = 4

        // 假設每個銅像之間有固定的水平和垂直間距
        let horizontalSpacing: CGFloat = 20
        let verticalSpacing: CGFloat = 20

        // 計算每個元件可顯示的最大寬度和高度
        let maxItemWidth = (availableWidth - CGFloat(itemsPerRow - 1) * horizontalSpacing) / CGFloat(itemsPerRow)
        let maxItemHeight = (availableHeight - CGFloat(itemsPerColumn - 1) * verticalSpacing) / CGFloat(itemsPerColumn)

        // 使用 VStack 和 HStack 來佈局縮放後的圖片
        layoutStatuesInGrid(availableWidth: availableWidth,
                            availableHeight: availableHeight,
                            itemsPerRow: itemsPerRow,
                            itemsPerColumn: itemsPerColumn,
                            maxItemSize: CGSize(width: maxItemWidth, height: maxItemHeight),
                            horizontalSpacing: horizontalSpacing,
                            verticalSpacing: verticalSpacing)
    }
    
    
    private func layoutStatuesInGrid(availableWidth: CGFloat, availableHeight: CGFloat,
                                     itemsPerRow: Int, itemsPerColumn: Int,
                                     maxItemSize: CGSize, horizontalSpacing: CGFloat, verticalSpacing: CGFloat) {
        // 創建 VStackNode，負責垂直排列
        let vStack = VStackNode(containerHeight: availableHeight)
        vStack.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2) // 放在螢幕中央
        self.addChild(vStack)

        // 所有生肖銅像的名稱
        let zodiacNames = ["Rat", "Ox", "Tiger", "Rabbit", "Dragon", "Snake", "Horse", "Goat", "Monkey", "Rooster", "Dog", "Pig"]

        // 排列圖像
        for row in 0..<itemsPerColumn {
            let hStack = HStackNode(containerWidth: availableWidth) // 每一排的寬度

            for column in 0..<itemsPerRow {
                let index = row * itemsPerRow + column
                if index < zodiacNames.count {
                    let statue = ScaledSpriteNode(imageNamed: zodiacNames[index], maxSize: maxItemSize)
                    hStack.addElement(statue) // 添加到 HStackNode
                }
            }

            // 將每一排 (HStack) 添加到 VStack 中
            vStack.addElement(hStack)
        }
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

