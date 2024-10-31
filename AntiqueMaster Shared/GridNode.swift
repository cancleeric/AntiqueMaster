//
//  GridNode.swift
//  AntiqueMaster
//  Created by EricWang on 2023/7/14.
//  修改記錄:
//  - 2024/10/20: 整理代碼，移除不必要的註解，並加上中文的文件說明。
//  - 2024/10/20: 改進透明度設置及網格標籤位置。
//  - 2024/10/20: 使用繁體中文加入 Xcode 文件說明註解，適應 SwiftUI 開發環境。
//  - 2024/10/22: 增加了 GridScene 類別，用來管理場景中的 GridNode。
//  - 2024/10/22: 修改 prepareNode 方法，使其能夠依據不同解析度動態調整網格和標籤的大小與位置。

import Foundation
import SpriteKit

/// `GridNode` 類別負責在場景中繪製網格，支援調整間距、線條寬度和顏色。
/// 可以用來輔助 UI 佈局或測試座標系統。
class GridNode: SKNode {

    /// 網格的間距
    var spacing: CGFloat

    /// 網格線條的寬度
    var lineWidth: CGFloat

    /// 網格線條的顏色
    var lineColor: UIColor

    /// 父節點容器，暫時未使用
    let parentNode = SKNode()

    /// 初始化 `Grid` 物件。
    /// - Parameters:
    ///   - spacing: 設置網格之間的間距，預設為 50。
    ///   - lineWidth: 設置網格線條的寬度，預設為 2。
    ///   - lineColor: 設置網格線條的顏色，預設為白色。
    init(spacing: CGFloat = 50, lineWidth: CGFloat = 2, lineColor: UIColor = .white) {
        self.spacing = spacing
        self.lineWidth = lineWidth
        self.lineColor = lineColor
        super.init()
    }

    /// 解碼器初始化方法，暫時不實作。
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 準備網格節點，並根據場景大小繪製水平與垂直的網格線。
    /// - Parameter size: 場景的大小。
    func prepareNode(size: CGSize) {

        DebugLogger.debug(" size: \(size)")

        // 根據場景大小動態調整網格的間距和字體大小
        let dynamicSpacing = max(50, size.width / 10)  // 根據螢幕寬度設定間距，最小為 50
        let dynamicFontSize = max(12, size.width / 30)  // 根據螢幕寬度設定字體大小，最小為 12

        // 繪製水平網格線
        for i in stride(from: 0, through: size.height, by: dynamicSpacing) {
            let path = CGMutablePath()
            path.move(to: CGPoint(x: 0, y: i))
            path.addLine(to: CGPoint(x: size.width, y: i))
            let line = SKShapeNode(path: path)
            line.lineWidth = lineWidth
            line.strokeColor = lineColor
            addChild(line)

            // 標記 Y 軸的座標值
            let label = SKLabelNode(text: "\(Int(i))")
            label.horizontalAlignmentMode = .left
            label.verticalAlignmentMode = .bottom
            label.position = CGPoint(x: 200, y: i)
            label.fontSize = dynamicFontSize
            label.fontName = "Helvetica-Bold"
            label.fontColor = lineColor
            addChild(label)
        }

        // 繪製垂直網格線
        for i in stride(from: 0, through: size.width, by: dynamicSpacing) {
            let path = CGMutablePath()
            path.move(to: CGPoint(x: i, y: 0))
            path.addLine(to: CGPoint(x: i, y: size.height))
            let line = SKShapeNode(path: path)
            line.lineWidth = lineWidth
            line.strokeColor = lineColor
            addChild(line)

            // 標記 X 軸的座標值
            let label = SKLabelNode(text: "\(Int(i))")
            label.horizontalAlignmentMode = .left
            label.verticalAlignmentMode = .bottom
            label.position = CGPoint(x: i, y: 400)
            label.fontSize = dynamicFontSize
            label.fontName = "Helvetica-Bold"
            label.fontColor = lineColor
            addChild(label)
        }

        // 設置透明度以顯示網格的可見性
        alpha = 0.5
    }

    /// 切換網格的可見性
    func toggleVisibility() {
        self.isHidden = !self.isHidden
    }
}
