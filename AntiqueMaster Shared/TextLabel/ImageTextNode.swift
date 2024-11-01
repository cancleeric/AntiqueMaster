//
//  ImageTextNode.swift
//  LifeSnap
//
//  Created by EricWang on 2023/8/9.
//

import SpriteKit

/// `ImageTextNode` 是一個自訂的 `SKNode` 子類別，用於顯示圖片和文字。此節點包含一個 `SKSpriteNode` 用於顯示圖片，以及一個 `SKLabelNode` 用於顯示文字。該類別提供設置文字內容、字體大小和字體顏色的功能。圖片和文字並排顯示，節點的整體框架會調整以包含兩者。
///
/// - Parameters:
///    - imageName: 用於 `SKSpriteNode` 的圖片名稱。
///    - text: 用於 `SKLabelNode` 的文字。
///    - fontSize: 文字的字體大小。
///    - fontColor: 文字的顏色。
class ImageTextNode: FrameSKNode {
    let imageNode: SKSpriteNode
    let textNode: SKLabelNode
    var numberNode: AnimatedMultiNumberLabel?  // 可選屬性

    let textNodeOffsetY = -1.0
    let imageName: String

    init(
        imageName: String, text: String, fontSize: CGFloat, fontColor: UIColor,
        imageSize: CGSize? = nil, number: Int? = nil
    ) {
        self.imageName = imageName
        textNode = SKLabelNode(text: text)
        textNode.fontColor = fontColor
        textNode.fontName = "HelveticaNeue-Bold"
        textNode.fontSize = fontSize
        textNode.verticalAlignmentMode = .center
        textNode.position = CGPoint(x: 0, y: textNodeOffsetY)

        imageNode = SKSpriteNode(imageNamed: imageName)
        let finalImageSize = imageSize ?? CGSize(width: fontSize, height: fontSize)
        imageNode.size = finalImageSize

        if let num = number {
            numberNode = AnimatedMultiNumberLabel(fontSize: fontSize)
            numberNode?.setValueImmediately(to: num)
        } else {
            numberNode = nil
        }

        super.init()

        addChild(textNode)

        if imageName != "" {
            addChild(imageNode)
        }

        if let numberNode = numberNode {
            addChild(numberNode)  // 只有在 numberNode 不為 nil 時才添加為子節點
        }

        layoutNodes()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 設置文字
    /// - Parameter text: 新的文字
    func setText(_ text: String) {
        textNode.text = text
        layoutNodes()
    }

    /// 設置字體大小
    /// - Parameter fontSize: 新的字體大小
    func setFontSize(_ fontSize: CGFloat) {
        textNode.fontSize = fontSize
        layoutNodes()
    }

    /// 設置數字
    /// - Parameter number: 新的數字
    func setNumber(_ number: Int) {
        if numberNode == nil {
            numberNode = AnimatedMultiNumberLabel(fontSize: textNode.fontSize)
            addChild(numberNode!)
        }
        numberNode?.startAnimation(targetNumber: number)
        layoutNodes()
    }

    /// 佈局節點
    private func layoutNodes() {
        let additionalWidth = numberNode?.frame.width ?? 0
        let totalWidth = imageNode.size.width + additionalWidth + textNode.frame.width

        // 計算起始位置
        var currentPositionX = -totalWidth / 2

        // 置中 imageNode
        imageNode.position = CGPoint(x: currentPositionX + imageNode.size.width / 2, y: 0)
        currentPositionX += imageNode.size.width

        // 如果 numberNode 存在，則置中 numberNode
        if let numberNode = numberNode {
            numberNode.position = CGPoint(x: currentPositionX + additionalWidth / 2, y: 0)
            currentPositionX += additionalWidth
        }

        // 置中 textNode
        textNode.position = CGPoint(
            x: currentPositionX + textNode.frame.width / 2, y: textNodeOffsetY)
    }
}
