//
//  VStackNode.swift
//  AntiqueMaster
//
//  Created by EricWang on 2024/10/19.
//  修改於 2024/11/01：新增 spacing 和 padding 屬性，並調整 layoutElements 方法以支援 SpacerNode。

import SpriteKit

class VStackNode: StackNode {
    private var containerHeight: CGFloat = 0  // 改名：容器的總高度

    // 初始化，設置容器高度、間距和 padding
    init(containerHeight: CGFloat, spacing: CGFloat = 0, padding: CGFloat = 0) {
        self.containerHeight = containerHeight
        super.init(spacing: spacing, padding: padding)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // 重新計算所有元件的位置與縮放
    override func layoutElements() {
        var contentHeight: CGFloat = 0
        var spacerNodes: [SpacerNode] = []
        var lastNode: SKNode?

        // 先計算非 SpacerNode 的總高度
        for element in elements {
            if let spacerNode = element as? SpacerNode {
                spacerNodes.append(spacerNode)
            } else {
                contentHeight += element.frame.height
                lastNode = element
            }
        }

        // 計算 SpacerNode 的高度
        let spacerHeight = max(
            0,
            (containerHeight - contentHeight - CGFloat(elements.count - spacerNodes.count - 1)
                * spacing - 2 * padding)
                / CGFloat(max(1, spacerNodes.count))
        )

        // 從最上方開始排列
        var currentY: CGFloat = containerHeight / 2 - padding

        // 重新排列所有元素
        for element in elements {
            if let spacerNode = element as? SpacerNode {
                spacerNode.size = CGSize(width: 1, height: spacerHeight)
            }
            
            currentY -= element.frame.height / 2
            element.position = CGPoint(x: 0, y: currentY)
            // 如果不是最後一個元素，則減去元素高度和間距
            if element != lastNode && !(element is SpacerNode)  {
                currentY -= element.frame.height / 2 + spacing
            } else {
                currentY -= element.frame.height / 2
            }
            
        }
    }
}
