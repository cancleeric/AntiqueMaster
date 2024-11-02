//
//  HStackNode.swift
//  AntiqueMaster
//
//  Created by EricWang on 2024/10/19.
//  修改於 2024/11/01：新增 spacing 和 padding 屬性，並調整 layoutElements 方法以支援 SpacerNode。

import SpriteKit

class HStackNode: StackNode {
    private var containerWidth: CGFloat = 0  // 容器的 總寬度

    // 初始化，設置容器寬度、間距和 padding
    init(containerWidth: CGFloat, spacing: CGFloat = 0, padding: CGFloat = 0) {
        self.containerWidth = containerWidth
        super.init(spacing: spacing, padding: padding)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // 重新計算所有元件的位置與縮放
    override func layoutElements() {
        var contentWidth: CGFloat = 0
        var spacerNodes: [SpacerNode] = []
        var lastNode: SKNode?

        // 先計算非 SpacerNode 的總寬度
        for element in elements {
            if let spacerNode = element as? SpacerNode {
                spacerNodes.append(spacerNode)
            } else {
                contentWidth += element.frame.width
                lastNode = element
            }
        }

        // 計算 SpacerNode 的寬度
        let spacerWidth = max(
            0,
            (self.containerWidth - contentWidth - CGFloat(elements.count - spacerNodes.count - 1)
                * spacing - 2 * padding)
                / CGFloat(max(1, spacerNodes.count))
        )

        // 從最左邊開始排列
        var currentX: CGFloat = -self.containerWidth / 2 + padding

        // 重新排列所有元素，先重新指定SpacerNode的Size, 在依下列規則排列, 如果不是最後一個元素也不是SpacerNode 則加上間距／2 ，其他則加上元素的寬度／2+spacing
        for element in elements {
            if let spacerNode = element as? SpacerNode {
                spacerNode.size = CGSize(width: spacerWidth, height: 1)
            }

            currentX += element.frame.size.width / 2
            element.position = CGPoint(x: currentX, y: 0)

            if element != lastNode && !(element is SpacerNode) {
                currentX += element.frame.size.width / 2 + spacing
            } else {
                currentX += element.frame.size.width / 2
            }
        }

    }
}
