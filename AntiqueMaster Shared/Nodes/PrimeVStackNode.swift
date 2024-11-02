//
//  PrimeVStackNode.swift
//  LifeSnap
//
//  Created by EricWang on 2023/9/29.
//
//  PrimeVStackNode 是一個擴展自 SKSpriteNode 的類別，
//  用於在 SpriteKit 場景中管理垂直堆疊的子節點。
//  支援設定內邊距、節點間距及對齊方式，並提供方法計算和更新節點的佈局尺寸。

import Foundation
import SpriteKit

class PrimeVStackNode: PrimeStackNode {

    var alignment: NSTextAlignment

    init(
        size: CGSize = .zero, padding: CGFloat = 0, spacing: CGFloat = 0,
        alignment: NSTextAlignment = .center
    ) {
        self.alignment = alignment
        super.init(size: size, padding: padding, spacing: spacing)
    }

    @MainActor required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 計算並更新 VStackNode 的尺寸
    /// - Parameter nodes: 要佈局在 VStackNode 中的子節點數組
    func calculateSizeForNodes(_ nodes: [SKNode]) -> CGSize {
        var totalHeight: CGFloat = padding * 2
        var maxWidth: CGFloat = 0

        for (index, node) in nodes.enumerated() {
            totalHeight += node.frame.size.height
            maxWidth = max(maxWidth, node.frame.size.width)
            if index < nodes.count - 1 {
                totalHeight += spacing
            }
        }

        return CGSize(width: maxWidth + padding * 2, height: totalHeight)
    }

    /// 添加內容節點並重新排列
    /// - Parameters:
    ///   - nodes: 要添加的子節點數組
    ///   - isAddChild: 是否將節點添加為子節點
    ///   - isUpdateWidth: 是否更新寬度
    ///   - recalculateSize: 是否重新計算尺寸
    func addContent(
        nodes: [SKNode], isAddChild: Bool = true, isUpdateWidth: Bool = true,
        recalculateSize: Bool = false
    ) {
        if recalculateSize {
            self.size = calculateSizeForNodes(nodes)
        }

        var yPosition: CGFloat = size.height / 2 - padding
        var totalHeight: CGFloat = 0
        var spacerNodes: [SpacerNode] = []

        for node in nodes {
            if let spacerNode = node as? SpacerNode {
                spacerNodes.append(spacerNode)
            } else {
                totalHeight += node.frame.size.height
            }
        }

        let spacerHeight =
            (size.height - totalHeight - CGFloat(nodes.count - 1) * spacing - 2 * padding)
            / CGFloat(spacerNodes.count)

        for node in nodes {
            if isAddChild {
                addChild(node)
            }

            if let spacerNode = node as? SpacerNode {
                spacerNode.size = CGSize(width: 1, height: spacerHeight)
            }

            yPosition -= node.frame.size.height / 2

            var xPosition: CGFloat
            switch alignment {
            case .left:
                xPosition = -size.width / 2 + node.frame.size.width / 2
            case .right:
                xPosition = size.width / 2 - node.frame.size.width / 2
            default:
                xPosition = 0
            }

            node.position = CGPoint(x: xPosition, y: yPosition)
            yPosition -= node.frame.size.height / 2 + spacing
        }

        if isUpdateWidth { updateWidth() }
    }

    /// 重新排列佈局
    /// - Parameter shouldResizeToFitContents: 是否應根據內容調整大小
    func recalculateLayout(shouldResizeToFitContents: Bool = true) {
        var yPosition: CGFloat = size.height / 2 - padding
        var totalHeight: CGFloat = 0
        var spacerNodes: [SpacerNode] = []

        for node in children {
            if let spacerNode = node as? SpacerNode {
                spacerNodes.append(spacerNode)
            } else {
                totalHeight += node.frame.size.height
            }
        }

        let spacerHeight = max(
            0,
            (size.height - totalHeight - CGFloat(children.count - spacerNodes.count - 1) * spacing
                - 2 * padding) / CGFloat(max(1, spacerNodes.count)))

        for node in children {
            if let spacerNode = node as? SpacerNode {
                spacerNode.size = CGSize(width: 1, height: spacerHeight)
            }

            yPosition -= node.frame.size.height / 2

            var xPosition: CGFloat = 0
            switch alignment {
            case .left:
                xPosition = -size.width / 2 + node.frame.size.width / 2 + padding
            case .right:
                xPosition = size.width / 2 - node.frame.size.width / 2 - padding
            default:
                break
            }

            node.position = CGPoint(x: xPosition, y: yPosition)
            yPosition -= node.frame.size.height / 2 + spacing
        }

        if shouldResizeToFitContents {
            updateWidth()
            updateHeight()
        }
    }
}
