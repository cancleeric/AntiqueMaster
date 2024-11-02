//
//  PrimeHStackNode.swift
//  LifeSnap
//
//  Created by EricWang on 2023/9/28.
//
//  PrimeHStackNode 是一個擴展自 SKSpriteNode 的類別，
//  用於在 SpriteKit 場景中管理水平堆疊的子節點。
//  支援設定內邊距、節點間距，並提供方法計算和更新節點的佈局尺寸。

import Foundation
import SpriteKit

class PrimeHStackNode: PrimeStackNode {

    /// 計算並更新 HStackNode 的尺寸
    /// - Parameter nodes: 要佈局在 HStackNode 中的子節點數組
    func calculateSizeForNodes(_ nodes: [SKNode]) -> CGSize {
        var totalWidth: CGFloat = padding * 2  // 開始和結束的填充
        var maxHeight: CGFloat = 0

        for (index, node) in nodes.enumerated() {
            totalWidth += node.frame.size.width
            maxHeight = max(maxHeight, node.frame.size.height)
            if index < nodes.count - 1 {
                totalWidth += spacing
            }
        }

        return CGSize(width: totalWidth, height: maxHeight + padding * 2)
    }

    /// 添加內容節點並重新排列
    /// - Parameters:
    ///   - nodes: 要添加的子節點數組
    ///   - recalculateSize: 是否重新計算尺寸
    func addContent(nodes: [SKNode], recalculateSize: Bool = false) {
        if recalculateSize {
            self.size = calculateSizeForNodes(nodes)
        }

        var xPosition: CGFloat = -size.width / 2 + padding
        var totalWidth: CGFloat = 0
        var spacerNodes: [SpacerNode] = []
        var lastNode: SKNode?

        for node in nodes {
            if let spacerNode = node as? SpacerNode {
                spacerNodes.append(spacerNode)
            } else {
                totalWidth += node.frame.size.width
                lastNode = node
            }
        }

        let spacerWidth = max(
            0,
            (size.width - totalWidth - CGFloat(nodes.count - spacerNodes.count - 1) * spacing
                - 2 * padding) / CGFloat(max(1, spacerNodes.count))
        )

        for node in nodes {
            if let spacerNode = node as? SpacerNode {
                spacerNode.size = CGSize(width: spacerWidth, height: 1)
            }

            xPosition += node.frame.size.width / 2
            node.position = CGPoint(x: xPosition, y: 0)
            addChild(node)

            if let spacerNode = node as? SpacerNode {
                xPosition += node.frame.size.width / 2
            } else if lastNode == node {
                xPosition += node.frame.size.width / 2
            } else {
                xPosition += node.frame.size.width / 2 + spacing
            }
        }
    }

    /// 重置子節點，可選擇性添加新的子節點
    /// - Parameter newNodes: 可選的新子節點數組
    func resetContent(with newNodes: [SKNode]? = nil) {
        self.removeAllChildren()
        if let nodes = newNodes {
            addContent(nodes: nodes)
        }
    }

    /// 重新計算子節點的佈局
    func recalculateLayout() {
        var xPosition: CGFloat = -size.width / 2 + padding
        var totalWidth: CGFloat = 0
        var spacerNodes: [SpacerNode] = []
        var lastNode: SKNode?

        let nodes = self.children

        for node in nodes {
            if let spacerNode = node as? SpacerNode {
                spacerNodes.append(spacerNode)
            } else {
                totalWidth += node.frame.size.width
                lastNode = node
            }
        }

        let spacerWidth = max(
            0,
            (size.width - totalWidth - CGFloat(nodes.count - spacerNodes.count - 1) * spacing
                - 2 * padding) / CGFloat(max(1, spacerNodes.count))
        )

        for node in nodes {
            if let spacerNode = node as? SpacerNode {
                spacerNode.size = CGSize(width: spacerWidth, height: 1)
            }

            xPosition += node.frame.size.width / 2
            node.position = CGPoint(x: xPosition, y: 0)

            if let spacerNode = node as? SpacerNode {
                xPosition += node.frame.size.width / 2
            } else if lastNode == node {
                xPosition += node.frame.size.width / 2
            } else {
                xPosition += node.frame.size.width / 2 + spacing
            }
        }
    }
}
