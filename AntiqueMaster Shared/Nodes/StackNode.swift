//
//  StackNode.swift
//  AntiqueMaster
//
//  Created by EricWang on 2024/11/01.
//

import SpriteKit

class StackNode: FrameSKNode {
    // 元件數組
    var elements: [SKNode] = []
    var spacing: CGFloat = 0  // 默認的 間距，可以動態調整
    var padding: CGFloat = 0  // 默認的 padding，可以動態調整

    // 初始化，設置間距和 padding
    init(spacing: CGFloat = 0, padding: CGFloat = 0) {
        self.spacing = spacing
        self.padding = padding
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // 覆載 frame 屬性，計算時加上 padding
    // override var frame: CGRect {
    //     let accumulatedFrame = self.calculateAccumulatedFrame()
    //     return accumulatedFrame.insetBy(dx: -padding, dy: -padding)
    // }

    // 新增單個元件到 StackNode，並重新計算排列
    func addElement(_ element: SKNode?) {
        guard let element = element else { return }
        elements.append(element)
        self.addChild(element)
        layoutElements()  // 每次添加完後重新計算位置
    }

    // 支援新增多個元件（陣列）到 StackNode
    func addElements(_ elementsArray: [SKNode?]) {
        for element in elementsArray {
            guard let element = element else { continue }
            elements.append(element)
            self.addChild(element)
        }
        layoutElements()  // 添加完後重新計算位置
    }

    // 重新計算所有元件的位置與縮放
    func layoutElements() {
        // 這個方法應該在子類別中實現
    }
}
