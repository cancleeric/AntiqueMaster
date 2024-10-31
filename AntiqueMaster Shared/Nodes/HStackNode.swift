//
//  HStackNode.swift
//  AntiqueMaster
//
//  Created by EricWang on 2024/10/19.
//

import SpriteKit

class HStackNode: FrameSKNode {

    // 元件數組
    private var elements: [SKNode] = []
    private var spacing: CGFloat = 0  // 默認的 間距，可以動態調整
    private var totalWidth: CGFloat = 0  // 容器的 總寬度

    // 初始化，設置容器寬度
    init(containerWidth: CGFloat) {
        super.init()
        self.totalWidth = containerWidth
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // 新增單個元件到 HStackNode，並重新計算排列
    func addElement(_ element: SKNode) {
        elements.append(element)
        self.addChild(element)
        layoutElements()  // 每次添加完後重新計 算位置
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
        var totalElementWidth: CGFloat = 0

        // 計算所有元件的原始總寬度
        for element in elements {
            totalElementWidth += element.frame.width
        }

        // 計算剩餘空間，並將其均分為間距
        let totalSpacing = totalWidth - totalElementWidth
        if elements.count > 1 {
            spacing = totalSpacing / CGFloat(elements.count - 1)
        } else {
            spacing = 0  // 如果只有一個元件，間距為0
        }

        // 設定起始 x 位置，從左至右依次排列，讓所有元件均勻排列
        var currentX: CGFloat = -totalWidth / 2

        // 重新排列所有元件，並調整每個元件的 x 位置
        for element in elements {
            // 計算每個元件的位置
            element.position = CGPoint(x: currentX + element.frame.width / 2, y: 0)
            currentX += element.frame.width + spacing
        }
    }
}
