//
//  ImageOutlinedTextNode.swift
//  LifeSnap
//
//  Created by EricWang on 2023/8/9.
//

import SpriteKit

/// `ImageOutlinedTextNode` 是一個自訂的 `FrameSKNode` 子類別，結合了圖片和帶有輪廓的文字。此節點包含一個 `SKSpriteNode` 用於顯示圖片，以及一個 `OutlinedLabelNode` 用於顯示文字。該類別提供設置圖片、文字、字體大小、字體顏色和輪廓顏色的功能。
///
/// - Parameters:
///    - imageName: 用於 `SKSpriteNode` 的圖片名稱。
///    - text: 用於 `OutlinedLabelNode` 的文字。
///    - fontSize: 文字的字體大小。
///    - fontColor: 文字的顏色。
///    - outlineColor: 文字輪廓的顏色。
///    - outlineWidth: 輪廓的寬度（默認為 1）。
class ImageOutlinedTextNode: AnimatedSKNode {
    let imageNode: SKSpriteNode
    let textNode: OutlinedLabelNode
    let textNodeOffsetY = -1.0
    let imageName: String

    init(
        imageName: String, text: String, fontSize: CGFloat, fontColor: UIColor,
        outlineColor: UIColor, outlineWidth: CGFloat = 1
    ) {
        self.imageName = imageName
        textNode = OutlinedLabelNode(
            text: text, fontSize: fontSize, fontColor: fontColor, outlineColor: outlineColor,
            outlineWidth: outlineWidth)
        textNode.verticalAlignmentMode = .center
        textNode.position = CGPoint(x: 0, y: textNodeOffsetY)

        imageNode = SKSpriteNode(imageNamed: imageName)
        let aspectRatio = imageNode.size.height / imageNode.size.width
        if imageNode.size.width > imageNode.size.height {
            imageNode.size = CGSize(width: fontSize, height: fontSize * aspectRatio)
        } else {
            imageNode.size = CGSize(width: fontSize / aspectRatio, height: fontSize)
        }

        super.init()

        addChild(textNode)
        let totalWidth = imageNode.size.width + textNode.label.frame.width
        if imageName != "" {
            addChild(imageNode)
            imageNode.position = CGPoint(x: -totalWidth / 2 + imageNode.size.width / 2, y: 0)
            textNode.position = CGPoint(
                x: totalWidth / 2 - textNode.label.frame.width / 2, y: textNodeOffsetY)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 設置文字的字體顏色
    /// - Parameter color: 新的字體顏色
    func setFontColor(_ color: UIColor) {
        textNode.setFontColor(color)
    }

    /// 設置文字的輪廓顏色
    /// - Parameter color: 新的輪廓顏色
    func setOutlineColor(_ color: UIColor) {
        textNode.setOutlineColor(color)
    }

    /// 設置文字
    /// - Parameter text: 新的文字
    func setText(_ text: String) {
        textNode.setText(text: text)
        adjustNodePositions()
    }

    /// 設置字體大小
    /// - Parameter fontSize: 新的字體大小
    func setFontSize(_ fontSize: CGFloat) {
        textNode.setFontSize(fontSize)
        adjustNodePositions()
    }

    /// 調整節點位置
    private func adjustNodePositions() {
        if imageName != "" {
            let totalWidth = imageNode.size.width + textNode.label.frame.width
            imageNode.position = CGPoint(x: -totalWidth / 2 + imageNode.size.width / 2, y: 0)
            textNode.position = CGPoint(
                x: totalWidth / 2 - textNode.label.frame.width / 2, y: textNodeOffsetY)
        }
    }
}
