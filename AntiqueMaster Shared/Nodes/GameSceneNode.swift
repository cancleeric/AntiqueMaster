//
//  GameSceneNode.swift
//  AntiqueMaster Shared
//
//  Created by EricWang on 2024/10/19.
//  - 新增 `GameSceneNode` 類別來管理安全區域內的遊戲元素。
//  - 實現 `setupSize(for:)` 方法來計算去除安全區域後的可用區域。
//  - 新增 `calculateNodeBounds(for:)` 方法來定義 `GameSceneNode` 的邊界。
//  - 該類別確保所有元素都位於安全且可用的區域內。

import SpriteKit

/// 管理安全區域內遊戲元素的節點
class GameSceneNode: FrameSKNode {

    var adjustedSize: CGSize = .zero

    /// 設置 GameSceneNode 的大小，去除安全區域後的可用區域
    func setupSize(for scene: SKScene) {
        let safeAreaInsets = SafeAreaManager.shared.safeAreaInsets
        let safeAreaInsetsWidth = safeAreaInsets.left + safeAreaInsets.right
        let safeAreaInsetsHeight = safeAreaInsets.top + safeAreaInsets.bottom
        adjustedSize = CGSize(
            width: scene.size.width - safeAreaInsetsWidth,
            height: scene.size.height - safeAreaInsetsHeight)

        self.position = CGPoint(
            x: safeAreaInsets.left + adjustedSize.width / 2,
            y: safeAreaInsets.bottom + adjustedSize.height / 2)

        self.calculateNodeBounds(for: adjustedSize)
    }

    /// 計算並設置節點的邊界
    private func calculateNodeBounds(for size: CGSize) {
        let boundary = SKShapeNode(rectOf: size)
        boundary.strokeColor = .blue
        boundary.lineWidth = 2
        self.addChild(boundary)
    }

    /// 添加子節點至 GameSceneNode
    func addGameNode(_ node: SKNode) {
        self.addChild(node)
    }
}
