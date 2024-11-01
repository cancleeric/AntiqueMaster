//
//  ImageTextNode.swift
//  LifeSnap
//
//  Created by EricWang on 2023/8/9.
//

import SpriteKit

/**
 A custom `FrameSKNode` subclass that combines an image and a text with an outline. This node includes an `SKSpriteNode` for the image and an `OutlinedLabelNode` for the text. The class provides functionality to set the image, text, font size, font color, and outline color.

 - Parameters:
    - imageName: The name of the image to be used in the `SKSpriteNode`.
    - text: The text to be displayed in the `OutlinedLabelNode`.
    - fontSize: The font size of the text.
    - fontColor: The color of the font.
    - outlineColor: The color of the outline around the text.
    - outlineWidth: The width of the outline (default is 1).
 */
class ImageOutlinedTextNode: AnimatedSKNode {
    let imageNode: SKSpriteNode
    let textNode: OutlinedLabelNode
    let textNodeOffsetY = -1.0
    let imageName: String
    
    init(imageName: String, text: String, fontSize: CGFloat, fontColor: UIColor, outlineColor: UIColor, outlineWidth: CGFloat = 1) {
        self.imageName = imageName
        textNode = OutlinedLabelNode(text: text, fontSize: fontSize, fontColor: fontColor, outlineColor: outlineColor, outlineWidth: CGFloat(outlineWidth))
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
            textNode.position = CGPoint(x: totalWidth / 2 - textNode.label.frame.width / 2, y: textNodeOffsetY)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setFontColor(_ color: UIColor) {
        textNode.setFontColor(color)
    }
    
    func setOutlineColor(_ color: UIColor) {
        textNode.setOutlineColor(color)
    }
    
    func setText(_ text: String) {
        textNode.setText(text: text)
        adjustNodePositions()
    }
    
    func setFontSize(_ fontSize: CGFloat) {
        textNode.setFontSize(fontSize)
        adjustNodePositions()
    }
    
    private func adjustNodePositions() {
        if imageName != "" {
            let totalWidth = imageNode.size.width + textNode.label.frame.width
            imageNode.position = CGPoint(x: -totalWidth / 2 + imageNode.size.width / 2, y: 0)
            textNode.position = CGPoint(x: totalWidth / 2 - textNode.label.frame.width / 2, y: textNodeOffsetY)
        }
    }

}

/**
 A custom `SKNode` subclass that displays an image alongside text. This node combines an `SKSpriteNode` for the image and an `SKLabelNode` for the text. The class allows customization of text content, font size, and font color. The image and text are positioned next to each other, and the overall frame of the node adjusts to encompass both.

 - Parameters:
    - imageName: The name of the image to be used in the `SKSpriteNode`.
    - text: The text to be displayed in the `SKLabelNode`.
    - fontSize: The font size of the text.
    - fontColor: The color of the font.
 */
class ImageTextNode: FrameSKNode {
    let imageNode: SKSpriteNode
    let textNode: SKLabelNode
    var numberNode: AnimatedMultiNumberLabel? // Changed to an optional property

    let textNodeOffsetY = -1.0
    let imageName: String
    
//    override var frame: CGRect {
//        return CGRect(x: min(imageNode.frame.minX, textNode.frame.minX),
//                      y: min(imageNode.frame.minY, textNode.frame.minY),
//                      width: max(imageNode.frame.maxX, textNode.frame.maxX) - min(imageNode.frame.minX, textNode.frame.minX),
//                      height: max(imageNode.frame.maxY, textNode.frame.maxY) - min(imageNode.frame.minY, textNode.frame.minY))
//    }
//
    
    // HStackNode for horizontal layout
//       var hStackNode: HStackNode
    
    init(imageName: String, text: String, fontSize: CGFloat, fontColor: UIColor, imageSize: CGSize? = nil, number: Int? = nil) {
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

//        imageNode.size = CGSize(width: fontSize, height: fontSize)
        
        if let num = number {
            numberNode = AnimatedMultiNumberLabel(fontSize: fontSize)
            numberNode?.setValueImmediately(to: num)
        } else {
            numberNode = nil
        }
        
//        hStackNode = HStackNode(size: CGSize(width: 0, height: fontSize), spacing: 0) // Adjust spacing as needed

        super.init()
        
        addChild(textNode)

        if imageName != "" {
            addChild(imageNode)
        }

        if let numberNode = numberNode {
            addChild(numberNode) // Add numberNode as a child only if it's not nil
        }
        // Add nodes to HStackNode
//        hStackNode.addContent(nodes: [imageNode, numberNode, textNode].compactMap { $0 })

        // Position HStackNode
//        hStackNode.position = CGPoint(x: 0, y: 0)
//        addChild(hStackNode)

        layoutNodes()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setText(_ text: String) {
        textNode.text = text
        layoutNodes()
    }
    
    func setFontSize(_ fontSize: CGFloat) {
        textNode.fontSize = fontSize
        layoutNodes()
    }
    
    func setNumber(_ number: Int) {
        if numberNode == nil {
            numberNode = AnimatedMultiNumberLabel(fontSize: textNode.fontSize)
            addChild(numberNode!)
        }
        numberNode?.startAnimation(targetNumber: number)// (to: number)
        layoutNodes()
    }
    
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
//            currentPositionX += additionalWidth / 2
            numberNode.position = CGPoint(x: currentPositionX + additionalWidth / 2, y: 0)
            currentPositionX += additionalWidth
        }

        // 置中 textNode
//        currentPositionX += textNode.frame.width / 2
        textNode.position = CGPoint(x: currentPositionX + textNode.frame.width / 2, y: textNodeOffsetY)
    }
//    private func layoutNodes() {
//        let additionalWidth = numberNode?.frame.width ?? 0
//        let totalWidth = imageNode.size.width + textNode.frame.width + additionalWidth
//
//        imageNode.position = CGPoint(x: -totalWidth / 2 + imageNode.size.width / 2, y: 0)
//        numberNode?.position = CGPoint(x: additionalWidth / 2, y: 0) // Position in the middle if it exists
//        textNode.position = CGPoint(x: totalWidth / 2 - textNode.frame.width / 2, y: textNodeOffsetY)
//    }
}

//    init(imageName: String, text: String, fontSize: CGFloat, fontColor: UIColor) {
//
//        self.imageName = imageName
//
//        textNode = SKLabelNode(text: text)
//        textNode.fontColor = fontColor
//
//        textNode.fontName = "HelveticaNeue-Bold"
//        textNode.fontSize = fontSize
//
//
//        textNode.verticalAlignmentMode = .center
//        // 較正文字向上偏移的問題
//        textNode.position = CGPoint(x: 0, y: textNodeOffsetY)
//
//        imageNode = SKSpriteNode(imageNamed: imageName)
//        imageNode.size = CGSize(width: fontSize, height: fontSize)
//
//
//        super.init()
//
//        addChild(textNode)
//        if imageName != "" {
//            addChild(imageNode)
//        }
//        calculateImageNodePosition()
//
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func setText(_ text: String) {
//        textNode.text = text
//        calculateImageNodePosition()
//        //        textNode.setText(text: text)
//    }
//
//    func setFontSize(_ fontSize: CGFloat) {
//        textNode.fontSize = fontSize
//        calculateImageNodePosition()
//        //        textNode.setFontSize(fontSize)
//    }
//
//    //    private
//
//    // 請創建一個新函式用來計算imageNode的position並在init時呼叫
//    func calculateImageNodePosition() {
//        let totalWidth = imageNode.size.width + textNode.frame.width
//
////        if imageName != "" {
//            imageNode.position = CGPoint(x: -totalWidth / 2 + imageNode.size.width / 2, y: 0)
//            textNode.position = CGPoint(x: totalWidth / 2 - textNode.frame.width / 2, y: textNodeOffsetY)
////        }
//    }
//}

//    func setText(_ text: String) {
//        textNode.setText(text: text)
//        if self.imageName != "" {
//            let totalWidth = imageNode.size.width + textNode.label.frame.width
//            imageNode.position = CGPoint(x: -totalWidth / 2 + imageNode.size.width / 2, y: 0)
//            textNode.position = CGPoint(x: totalWidth / 2 - textNode.label.frame.width / 2, y: textNodeOffsetY)
//        }
//    }
//
//    func setFontSize(_ fontSize: CGFloat) {
//        textNode.setFontSize(fontSize)
//        if imageName != "" {
//            let totalWidth = imageNode.size.width + textNode.label.frame.width
//            imageNode.position = CGPoint(x: -totalWidth / 2 + imageNode.size.width / 2, y: 0)
//            textNode.position = CGPoint(x: totalWidth / 2 - textNode.label.frame.width / 2, y: textNodeOffsetY)
//        }
//    }
// 添加 width 屬性
//    var width: CGFloat {
//        return imageNode.size.width + textNode.label.frame.width
//    }

//    init(imageName: String, text: String, fontSize: CGFloat, fontColor: UIColor, outlineColor: UIColor, outlineWidth: Int = 1) {
//        self.imageName = imageName
//        textNode = OutlinedLabelNode(text: text, fontSize: fontSize, fontColor: fontColor, outlineColor: outlineColor, outlineWidth: outlineWidth)
//        textNode.verticalAlignmentMode = .center
//        // 較正文字向上偏移的問題
//        textNode.position = CGPoint(x: 0, y: textNodeOffsetY)
//
////        imageNode = SKSpriteNode(imageNamed: imageName)
////        imageNode.size = CGSize(width: fontSize, height: fontSize)
////
//
//        imageNode = SKSpriteNode(imageNamed: imageName)
//        let aspectRatio = imageNode.size.height / imageNode.size.width
//        if imageNode.size.width > imageNode.size.height {
//            imageNode.size = CGSize(width: fontSize, height: fontSize * aspectRatio)
//        } else {
//            imageNode.size = CGSize(width: fontSize / aspectRatio, height: fontSize)
//        }
//
//        super.init()
//
//        addChild(textNode)
//        let totalWidth = imageNode.size.width + textNode.label.frame.width
//        if imageName != "" {
//            addChild(imageNode)
//            imageNode.position = CGPoint(x: -totalWidth / 2 + imageNode.size.width / 2, y: 0)
//            textNode.position = CGPoint(x: totalWidth / 2 - textNode.label.frame.width / 2, y: textNodeOffsetY)
//        }
//
//    }
