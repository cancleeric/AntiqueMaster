//
//  ZodiacManagerNode.swift
//  AntiqueMaster Shared
//
//  Created by EricWang on 2024/10/29.
//  - 新增 `ZodiacManagerNode` 類別來管理 ZodiacNode 的創建和佈局。
//  - 該類別負責在網格佈局中生成和排列 12 個 Zodiac 節點。
//  - 佈局是靈活的，根據可用的屏幕空間進行調整。

import SpriteKit

/// 管理 ZodiacNode 創建和佈局的節點
class ZodiacManagerNode: SKNode {
    let itemsPerRow = 3
    let itemsPerColumn = 4
    let horizontalSpacing: CGFloat = 20
    let verticalSpacing: CGFloat = 20

    /// 設置 Zodiac 節點
    func setupZodiacNodes(in scene: SKScene, availableWidth: CGFloat, availableHeight: CGFloat) {
        let maxItemWidth =
            (availableWidth - CGFloat(itemsPerRow - 1) * horizontalSpacing) / CGFloat(itemsPerRow)
        let maxItemHeight =
            (availableHeight - CGFloat(itemsPerColumn - 1) * verticalSpacing)
            / CGFloat(itemsPerColumn)
        let maxItemSize = CGSize(width: maxItemWidth, height: maxItemHeight)

        let vStack = VStackNode(containerHeight: availableHeight)
        self.addChild(vStack)

        for row in 0..<itemsPerColumn {
            let hStack = HStackNode(containerWidth: availableWidth)
            for column in 0..<itemsPerRow {
                let index = row * itemsPerRow + column
                if index < ZodiacNode.zodiacNames.count {
                    let statue = ZodiacNode(
                        name: ZodiacNode.zodiacNames[index], maxSize: maxItemSize)
                    hStack.addElement(statue)
                }
            }
            vStack.addElement(hStack)
        }
    }
}
