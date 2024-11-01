//
//  OutlinedLabelNode.swift
//  LifeSnap
//
//  Created by EricWang on 2023/7/26.
//

import SpriteKit

class OutlinedLabelNode: FrameSKNode {
    let label: SKLabelNode

    init(
        text: String, fontSize: CGFloat, fontColor: UIColor, outlineColor: UIColor,
        outlineWidth: CGFloat
    ) {
        label = SKLabelNode(text: text)
        label.fontName = "HelveticaNeue-Bold"
        label.fontSize = fontSize
        label.fontColor = fontColor
        //        label.verticalAlignmentMode = .center

        super.init()

        // 定义一个细边框的偏移量数组
        let offsets: [CGFloat] = [-outlineWidth, 0, outlineWidth]

        for xOffset in offsets {
            for yOffset in offsets {

                //
                //        for xOffset in -outlineWidth...outlineWidth {
                //            for yOffset in -outlineWidth...outlineWidth {
                let outlineLabel = SKLabelNode(text: text)
                outlineLabel.fontName = "HelveticaNeue-Bold"
                outlineLabel.fontSize = fontSize
                outlineLabel.fontColor = outlineColor
                outlineLabel.position = CGPoint(x: CGFloat(xOffset), y: CGFloat(yOffset))
                //                outlineLabel.verticalAlignmentMode = .center
                addChild(outlineLabel)
            }
        }

        addChild(label)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //    private func clear() {
    //        self.removeAllChildren()
    //        self.removeAllActions()
    //    }
    //
    //    deinit {
    //        clear()
    //    }

    func setFontColor(_ color: UIColor) {
        label.fontColor = color
    }

    func setOutlineColor(_ color: UIColor) {

        for child in children {
            if let outlineLabel = child as? SKLabelNode, outlineLabel != label {
                outlineLabel.fontColor = color
            }
        }
    }

    //  MARK: - Animation
    let fadeInDuration: TimeInterval = 0.3
    let waitDuration: TimeInterval = 1
    let fadeOutDuration: TimeInterval = 0.3

    func animateFadeInFadeOut(completion: @escaping () -> Void) {
        let fadeIn = SKAction.fadeIn(withDuration: fadeInDuration)
        let wait = SKAction.wait(forDuration: waitDuration)
        let fadeOut = SKAction.fadeOut(withDuration: fadeOutDuration)

        let sequence = SKAction.sequence([fadeIn, wait, fadeOut])
        run(sequence, completion: completion)
    }

    func animateTotalTime() -> CGFloat {
        return fadeInDuration + waitDuration + fadeInDuration
    }

    func setText(text: String) {
        // Update the text of the main label node
        label.text = text

        // Update the text of the outline label nodes
        for child in children {
            if let outlineLabel = child as? SKLabelNode {
                outlineLabel.text = text
            }
        }
    }

    func setFontSize(_ fontSize: CGFloat) {
        label.fontSize = fontSize  // 設定 label 的字型大小
        for child in children {
            if let outlineLabel = child as? SKLabelNode, outlineLabel != label {
                outlineLabel.fontSize = fontSize  // 設定外框的字型大小
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
