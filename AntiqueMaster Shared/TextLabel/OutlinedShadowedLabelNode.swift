//
//  OutlinedShadowedLabelNode.swift
//  LifeSnap
//
//  Created by EricWang on 2024/2/20.
//

import SpriteKit

class OutlinedShadowedLabelNode: FrameSKNode {
    var outlinedLabelNode: OutlinedLabelNode
    var shadowedLabelNode: ShadowedLabel

    init(text: String, fontSize: CGFloat = 16.0, fontColor: UIColor = .white, outlineColor: UIColor = .darkGray, outlineWidth: CGFloat = 1, shadowColor: UIColor = .black, shadowOffset: CGPoint = CGPoint(x: 0, y: -2)) {
        // Initialize the OutlinedLabelNode with specified parameters
        outlinedLabelNode = OutlinedLabelNode(text: text, fontSize: fontSize, fontColor: fontColor, outlineColor: outlineColor, outlineWidth: outlineWidth)
        
        // Initialize the ShadowedLabel with specified parameters, adjusting the shadowOffset as needed
        shadowedLabelNode = ShadowedLabel(text: text, fontSize: fontSize, fontColor: fontColor, shadowColor: shadowColor)
        shadowedLabelNode.shadowLabel.position = shadowOffset

        super.init()

        setupComponents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setText(text: String) {
        outlinedLabelNode.setText(text: text)
        shadowedLabelNode.setText(text: text)
    }
    
    private func setupComponents() {
        // Add the shadowed label first so it appears behind the outlined label
        addChild(shadowedLabelNode)
        
        // Add the outlined label on top
        addChild(outlinedLabelNode)
    }
    
    var verticalAlignmentMode: SKLabelVerticalAlignmentMode = .baseline {
        didSet {
            outlinedLabelNode.verticalAlignmentMode = verticalAlignmentMode
            shadowedLabelNode.verticalAlignmentMode = verticalAlignmentMode
        }
    }
}


