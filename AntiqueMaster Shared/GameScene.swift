//
//  GameScene.swift
//  AntiqueMaster Shared
//
//  Created by EricWang on 2024/10/19.
//  Modify: 2024/10/29
//  - 新增 `GameSceneNode` 類別來管理安全區域內的遊戲元素。
//  - 實現 `setupSize(for:)` 方法來計算去除安全區域後的可用區域。
//  - 新增 `calculateNodeBounds(for:)` 方法來定義 `GameSceneNode` 的邊界。
//  - 更新 `GameScene` 類別以包含 `GameSceneNode`，確保所有元素都位於安全且可用的區域內。
//  - 改進 `layoutStatuesInGrid(...)` 方法以動態網格佈局，支持根據可用屏幕空間靈活定位銅像。
//  - 改進 iOS 和 macOS 的觸摸和滑鼠事件處理，增加交互的視覺反饋。
//  - 增加代碼註解和文檋以提高可讀性和可維護性。
//  - 更新 `assignRolesToPlayers` 方法以支持 8 名玩家。
//  - 新增 `ZodiacManagerNode` 類別來管理 ZodiacNode 的創建和佈局。
//  - 新增 `GameRoleLabelManagerNode` 類別來管理玩家角色標籤的創建和佈局。
//  - 新增 `GameDataCenter` 類別來管理遊戲數據，例如玩家信息。

import SpriteKit

/// 遊戲場景類別，負責管理遊戲中的所有元素和邏輯
class GameScene: GridScene {

    var gameSceneNode: GameSceneNode?
    var developmentNode: DevelopmentNode?  // 新增開發用的NODE

    fileprivate var label: SKLabelNode?

    /// 創建新的遊戲場景
    class func newGameScene() -> GameScene {
        guard let scene = SKScene(fileNamed: "GameScene") as? GameScene else {
            print("Failed to load GameScene.sks")
            abort()
        }
        scene.scaleMode = .aspectFill
        return scene
    }

    /// 設置場景中的元素
    func setUpScene() {
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }

        // 移除旋轉節點的設置
        // let w = (self.size.width + self.size.height) * 0.05
        // self.spinnyNode = SKShapeNode(
        //     rectOf: CGSize(width: w, height: w), cornerRadius: w * 0.3)

        // if let spinnyNode = self.spinnyNode {
        //     spinnyNode.lineWidth = 4.0
        //     spinnyNode.run(
        //         SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
        //     spinnyNode.run(
        //         SKAction.sequence([
        //             SKAction.wait(forDuration: 0.5),
        //             SKAction.fadeOut(withDuration: 0.5),
        //             SKAction.removeFromParent(),
        //         ]))
        // }
    }

    /// 當場景被添加到視圖時調用
    override func didMove(to view: SKView) {
        super.didMove(to: view)

        GameDataCenter.shared.initializeGameDataCenter()  // 初始化遊戲數據中心

        gameSceneNode = GameSceneNode()
        guard let gameSceneNode = gameSceneNode else { return }

        gameSceneNode.setupSize(for: self)
        self.addChild(gameSceneNode)

        self.setUpScene()
        self.backgroundColor = SKColor.white

        let adjustedSize = gameSceneNode.adjustedSize

        developmentNode = DevelopmentNode()
        guard let developmentNode = developmentNode else { return }

        developmentNode.setupNodes(
            in: self, availableWidth: adjustedSize.width, availableHeight: adjustedSize.height)
        gameSceneNode.addChild(developmentNode)

        developmentNode.assignRolesToPlayers()
    }

    // 移除 makeSpinny 方法
    // /// 創建旋轉節點
    // func makeSpinny(at pos: CGPoint, color: SKColor) {
    //     if let spinny = self.spinnyNode?.copy() as! SKShapeNode? {
    //         spinny.position = pos
    //         spinny.strokeColor = color
    //         self.addChild(spinny)
    //     }
    // }

    /// 每幀渲染前調用
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

#if os(iOS) || os(tvOS)
    // 基於觸摸的事件處理
    extension GameScene {

        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            if let label = self.label {
                label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
            }

            for t in touches {
                developmentNode?.makeSpinny(at: t.location(in: self), color: SKColor.green)
            }
        }

        override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            for t in touches {
                developmentNode?.makeSpinny(at: t.location(in: self), color: SKColor.blue)
            }
        }

        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            for t in touches {
                developmentNode?.makeSpinny(at: t.location(in: self), color: SKColor.red)
            }
        }

        override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
            for t in touches {
                developmentNode?.makeSpinny(at: t.location(in: self), color: SKColor.red)
            }
        }

    }
#endif
