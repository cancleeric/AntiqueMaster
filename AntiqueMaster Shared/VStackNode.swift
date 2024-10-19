//
//  VStackNode.swift
//  AntiqueMaster
//
//  Created by EricWang on 2024/10/19.
//

import SpriteKit

class VStackNode: SKSpriteNode {

    // 元件數組
    private var elements: [SKSpriteNode] = []
    private var spacing: CGFloat = 0 // 默認的間距，可以動態調整
    private var totalHeight: CGFloat = 0 // 容器的總高度

    // 初始化，設置容器高度
    init(containerHeight: CGFloat) {
        super.init(texture: nil, color: .clear, size: CGSize(width: 0, height: containerHeight))
        self.totalHeight = containerHeight
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // 新增單個元件到 VStackNode，並重新計算排列
    func addElement(_ element: SKSpriteNode) {
        elements.append(element)
        self.addChild(element)
        layoutElements() // 每次添加完後重新計算位置
    }

    // 支援新增多個元件（陣列）到 VStackNode
    func addElements(_ elementsArray: [SKSpriteNode]) {
        elements.append(contentsOf: elementsArray) // 添加陣列中的所有元素
        for element in elementsArray {
            self.addChild(element)
        }
        layoutElements() // 添加完後重新計算位置
    }

    // 重新計算所有元件的位置與縮放
    private func layoutElements() {
        var totalElementHeight: CGFloat = 0

        // 計算所有元件的原始總高度
        for element in elements {
            totalElementHeight += element.size.height
        }

        // 計算剩餘空間，並將其均分為間距
        let totalSpacing = totalHeight - totalElementHeight
        if elements.count > 1 {
            spacing = totalSpacing / CGFloat(elements.count - 1)
        } else {
            spacing = 0 // 如果只有一個元件，間距為0
        }

        // 設定起始 y 位置，從上到下依次排列，讓所有元件均勻排列
        var currentY: CGFloat = totalHeight / 2

        // 重新排列所有元件，並調整每個元件的 y 位置
        for element in elements {
            // 計算每個元件的位置
            currentY -= element.size.height / 2
            element.position = CGPoint(x: 0, y: currentY)
            currentY -= element.size.height / 2 + spacing
        }
    }
}
