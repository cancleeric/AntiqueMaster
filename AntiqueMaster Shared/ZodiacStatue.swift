//
//  ZodiacStatue.swift
//  AntiqueMaster
//
//  Created by EricWang on 2024/10/19.
//

import SpriteKit

class ZodiacStatue {
    var spriteNode: SKSpriteNode
    
    init(imageNamed: String, position: CGPoint, scale: CGFloat) {
        self.spriteNode = SKSpriteNode(imageNamed: imageNamed)
        self.spriteNode.position = position
        self.spriteNode.setScale(scale)
    }
    
    func addToScene(scene: SKScene) {
        scene.addChild(self.spriteNode)
    }
}
