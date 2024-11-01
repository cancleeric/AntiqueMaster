//
//  VStackNode.swift
//  AntiqueMaster
//
//  Created by EricWang on 2024/10/19.
//

import SpriteKit

class VStackNode: SKSpriteNode {

    // 元件數組
    private var elements: [SKNode] = []
    private var spacing: CGFloat = 0  // 默認的 間距，可以動態調整
    private var totalHeight: CGFloat = 0  // 容器的 總高度
    private var padding: CGFloat = 0  // 默認的 padding，可以動態調整

    // 初始化，設置容器高度、間距和 padding
    init(containerHeight: CGFloat, spacing: CGFloat = 0, padding: CGFloat = 0) {
        self.totalHeight = containerHeight
        self.spacing = spacing
        self.padding = padding
        super.init(texture: nil, color: .clear, size: CGSize(width: 0, height: containerHeight))
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // 新增單個元件到 VStackNode，並重新計算排列
    func addElement(_ element: SKNode) {
        elements.append(element)
        self.addChild(element)
        layoutElements()  // 每次添加完後重新計算位置
    }

    // 支援新增多個元件（陣列）到 VStackNode
    func addElements(_ elementsArray: [SKNode]) {
        elements.append(contentsOf: elementsArray)  // 添加陣列中的所有元素
        for element in elementsArray {
            self.addChild(element)
        }
        layoutElements()  // 添加完後重新計算位置
    }

    // 重新計算所有元件的位置與縮放
    private func layoutElements() {
        var totalElementHeight: CGFloat = 0
        var spacerCount: Int = 0

        // 計算固定高度的元素總高度和 SpacerNode 的數量
        for element in elements {
            if element is SpacerNode {
                spacerCount += 1
            } else {
                totalElementHeight += element.frame.height
            }
        }

        // 計算總間距
        let totalSpacing = spacing * CGFloat(elements.count - 1)

        // 計算每個 SpacerNode 的高度
        let availableHeight = totalHeight - padding * 2 - totalElementHeight - totalSpacing
        let spacerHeight = spacerCount > 0 ? availableHeight / CGFloat(spacerCount) : 0

        // 設定起始 y 位置，從上到下依次排列，讓所有元件均勻排列
        var currentY: CGFloat = totalHeight / 2 - padding

        // 重新排列所有元件，並調整每個元件的 y 位置
        for element in elements {
            if let spacer = element as? SpacerNode {
                spacer.size.height = spacerHeight
                currentY -= spacer.size.height / 2
                spacer.position = CGPoint(x: 0, y: currentY)
                currentY -= spacer.size.height / 2 + spacing
            } else {
                currentY -= element.frame.height / 2
                element.position = CGPoint(x: 0, y: currentY)
                currentY -= element.frame.height / 2 + spacing
            }
        }
    }
}
