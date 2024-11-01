//
//  HStackNode.swift
//  AntiqueMaster
//
//  Created by EricWang on 2024/10/19.
//  修改於 2024/11/01：新增 spacing 和 padding 屬性，並調整 layoutElements 方法以支援 SpacerNode。

import SpriteKit

class HStackNode: StackNode {
    private var totalWidth: CGFloat = 0  // 容器的 總寬度

    // 初始化，設置容器寬度、間距和 padding
    init(containerWidth: CGFloat, spacing: CGFloat = 0, padding: CGFloat = 0) {
        self.totalWidth = containerWidth
        super.init(spacing: spacing, padding: padding)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // 重新計算所有元件的位置與縮放
    override func layoutElements() {
        var currentX = -totalWidth / 2 + padding
        var totalFixedWidth: CGFloat = 0
        var spacerCount: Int = 0

        // 計算固定寬度的元素總寬度和 SpacerNode 的數量
        for element in elements {
            if element is SpacerNode {
                spacerCount += 1
            } else {
                totalFixedWidth += element.frame.width
            }
        }

        // 計算每個 SpacerNode 的寬度
        let totalSpacing = CGFloat(elements.count - 1) * spacing
        let availableWidth = totalWidth - padding * 2 - totalFixedWidth - totalSpacing
        let spacerWidth = spacerCount > 0 ? availableWidth / CGFloat(spacerCount) : 0

        // 重新排列所有元素
        for element in elements {
            if let spacer = element as? SpacerNode {
                spacer.size.width = spacerWidth
                spacer.position = CGPoint(x: currentX + spacer.size.width / 2, y: 0)
                currentX += spacer.size.width + spacing
            } else {
                element.position = CGPoint(x: currentX + element.frame.width / 2, y: 0)
                currentX += element.frame.width + spacing
            }
        }
    }
}
