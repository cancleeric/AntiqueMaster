//
//  OutlinedLabelNode.swift
//  LifeSnap
//
//  Created by EricWang on 2023/7/26.
//  修改於 2024/11/02：調整 label 的 zPosition，使其顯示在最上層。

import SpriteKit

/// OutlinedLabelNode 是一個帶有外框的文字節點
class OutlinedLabelNode: FrameSKNode {
    let label: SKLabelNode

    /// 初始化 OutlinedLabelNode
    /// - Parameters:
    ///   - text: 文字內容
    ///   - fontSize: 字體大小
    ///   - fontColor: 字體顏色
    ///   - outlineColor: 外框顏色
    ///   - outlineWidth: 外框寬度
    init(
        text: String, fontSize: CGFloat, fontColor: UIColor, outlineColor: UIColor,
        outlineWidth: CGFloat
    ) {
        label = SKLabelNode(text: text)
        label.fontName = "HelveticaNeue-Bold"
        label.fontSize = fontSize
        label.fontColor = fontColor

        super.init()

        // 定義一個細邊框的偏移量數組
        let offsets: [CGFloat] = [-outlineWidth, 0, outlineWidth]

        for xOffset in offsets {
            for yOffset in offsets {
                let outlineLabel = SKLabelNode(text: text)
                outlineLabel.fontName = "HelveticaNeue-Bold"
                outlineLabel.fontSize = fontSize
                outlineLabel.fontColor = outlineColor
                outlineLabel.position = CGPoint(x: CGFloat(xOffset), y: CGFloat(yOffset))
                addChild(outlineLabel)
            }
        }

        addChild(label)
        label.zPosition = 1
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 設置字體顏色
    /// - Parameter color: 新的字體顏色
    func setFontColor(_ color: UIColor) {
        label.fontColor = color
    }

    /// 設置外框顏色
    /// - Parameter color: 新的外框顏色
    func setOutlineColor(_ color: UIColor) {
        for child in children {
            if let outlineLabel = child as? SKLabelNode, outlineLabel != label {
                outlineLabel.fontColor = color
            }
        }
    }

    // MARK: - 動畫相關

    let fadeInDuration: TimeInterval = 0.3
    let waitDuration: TimeInterval = 1
    let fadeOutDuration: TimeInterval = 0.3

    /// 執行淡入淡出動畫
    /// - Parameter completion: 動畫完成後的回調
    func animateFadeInFadeOut(completion: @escaping () -> Void) {
        let fadeIn = SKAction.fadeIn(withDuration: fadeInDuration)
        let wait = SKAction.wait(forDuration: waitDuration)
        let fadeOut = SKAction.fadeOut(withDuration: fadeOutDuration)

        let sequence = SKAction.sequence([fadeIn, wait, fadeOut])
        run(sequence, completion: completion)
    }

    /// 獲取動畫總時長
    /// - Returns: 動畫總時長
    func animateTotalTime() -> CGFloat {
        return fadeInDuration + waitDuration + fadeInDuration
    }

    /// 設置文字內容
    /// - Parameter text: 新的文字內容
    func setText(text: String) {
        label.text = text
        for child in children {
            if let outlineLabel = child as? SKLabelNode {
                outlineLabel.text = text
            }
        }
    }

    /// 設置字體大小
    /// - Parameter fontSize: 新的字體大小
    func setFontSize(_ fontSize: CGFloat) {
        label.fontSize = fontSize
        for child in children {
            if let outlineLabel = child as? SKLabelNode, outlineLabel != label {
                outlineLabel.fontSize = fontSize
            }
        }
    }

    var verticalAlignmentMode: SKLabelVerticalAlignmentMode = .baseline {
        didSet {
            label.verticalAlignmentMode = verticalAlignmentMode
            for child in children {
                if let outlineLabel = child as? SKLabelNode {
                    outlineLabel.verticalAlignmentMode = verticalAlignmentMode
                }
            }
        }
    }

    var horizontalAlignmentMode: SKLabelHorizontalAlignmentMode = .center {
        didSet {
            label.horizontalAlignmentMode = horizontalAlignmentMode
            for child in children {
                if let outlineLabel = child as? SKLabelNode {
                    outlineLabel.horizontalAlignmentMode = horizontalAlignmentMode
                }
            }
        }
    }
}
