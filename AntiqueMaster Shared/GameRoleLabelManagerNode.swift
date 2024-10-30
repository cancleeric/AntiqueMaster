//
//  GameRoleLabelManagerNode.swift
//  AntiqueMaster Shared
//
//  Created by EricWang on 2024/10/29.
//  - 新增 `GameRoleLabelManagerNode` 類別來管理玩家角色標籤的創建和佈局。
//  - 該類別負責在場景中生成和排列玩家角色標籤。

import SpriteKit

/// 管理玩家角色標籤的節點
class GameRoleLabelManagerNode: SKNode {
    /// 設置玩家角色標籤
    func setupPlayerRoleLabels(players: [Player], adjustedSize: CGSize) {
        self.enumerateChildNodes(withName: "playerLabel") { node, _ in
            node.removeFromParent()
        }

        let startX: CGFloat = -adjustedSize.width / 2 + 50
        let startY: CGFloat = adjustedSize.height / 2 - 50
        let verticalSpacing: CGFloat = 30

        for (index, player) in players.enumerated() {
            let label = SKLabelNode(text: "\(player.name): \(player.role?.rawValue ?? "未分配")")
            label.fontName = "Helvetica-Bold"
            label.fontSize = 20
            label.fontColor = .black
            label.position = CGPoint(x: startX, y: startY - CGFloat(index) * verticalSpacing)
            label.horizontalAlignmentMode = .left
            label.name = "playerLabel"
            self.addChild(label)
        }
    }
}
