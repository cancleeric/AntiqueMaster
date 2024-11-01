//
//  HStackNode.swift
//  AntiqueMaster
//
//  Created by EricWang on 2024/10/19.
//

import SpriteKit

class HStackNode: SKSpriteNode {

    // 元件數組
    private var elements: [SKNode] = []
    private var spacing: CGFloat = 0  // 默認的 間距，可以動態調整
    private var totalWidth: CGFloat = 0  // 容器的 總寬度
    private var padding: CGFloat = 0  // 默認的 padding，可以動態調整

    // 初始化，設置容器寬度、間距和 padding
    init(containerWidth: CGFloat, spacing: CGFloat = 0, padding: CGFloat = 0) {
        self.totalWidth = containerWidth
        self.spacing = spacing
        self.padding = padding
        super.init(texture: nil, color: .clear, size: CGSize(width: containerWidth, height: 1))
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // 新增單個元件到 HStackNode，並重新計算排列
    func addElement(_ element: SKNode) {
        elements.append(element)
        self.addChild(element)
        layoutElements()  // 每次添加完後重新計算位置
    }

    // 支援新增多個元件（陣列）到 HStackNode
    func addElements(_ elementsArray: [SKNode]) {
        elements.append(contentsOf: elementsArray)  // 添加陣列中的所有元素
        for element in elementsArray {
            self.addChild(element)
        }
        layoutElements()  // 添加完後重新計算位置
    }

    // 重新計算所有元件的位置與縮放
    private func layoutElements() {
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
