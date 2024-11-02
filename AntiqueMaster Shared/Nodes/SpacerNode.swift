//
//  SpacerNode.swift
//  AntiqueMaster iOS
//
//  Created by EricWang on 2023/9/28.
//

import SpriteKit

/// SpacerNode 是一個透明的節點，用於在佈局中創建可調整大小的間隔。
class SpacerNode: SKSpriteNode {
    init() {
        super.init(texture: nil, color: .gray, size: CGSize(width: 1, height: 1))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
extension SKSpriteNode {
    func showBorder() {
        let BorderedNode = BorderedNode(size: self.frame.size)
        self.addChild(BorderedNode)
        //        BorderedNode.zPosition = self.zPosition - 1
    }
}
