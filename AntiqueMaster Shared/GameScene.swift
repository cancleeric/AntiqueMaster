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
//  - 集成 `GameHomeNode` 以管理遊戲首頁的 UI 元素。

import SpriteKit

/// 遊戲場景類別，負責管理遊戲中的所有元素和邏輯
class GameScene: GridScene {

    var gameSceneNode: GameSceneNode?
    var developmentNode: DevelopmentNode?  // 新增開發用的NODE
    var gameHomeNode: GameHomeNode?  // 新增遊戲首頁 NODE

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
            availableWidth: adjustedSize.width, availableHeight: adjustedSize.height)
        // gameSceneNode.addChild(developmentNode)

        developmentNode.assignRolesToPlayers()

        // Initialize and add GameHomeNode
        gameHomeNode = GameHomeNode()
        guard let gameHomeNode = gameHomeNode else { return }
        gameHomeNode.setupNodes(
            availableWidth: adjustedSize.width, availableHeight: adjustedSize.height)
        gameSceneNode.addGameNode(gameHomeNode)
    }

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
