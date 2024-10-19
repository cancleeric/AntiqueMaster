//
//  ScaledSpriteNode.swift
//  AntiqueMaster
//
//  Created by EricWang on 2024/10/19.
//

import SpriteKit

// 繼承 SKSpriteNode 的類別，內置縮放邏輯
class ScaledSpriteNode: SKSpriteNode {

    // 初始化方法
    init(imageNamed name: String, maxSize: CGSize) {
        let texture = SKTexture(imageNamed: name) // 創建 SKTexture
        super.init(texture: texture, color: .clear, size: texture.size()) // 使用圖片原始大小初始化
        self.scaleToFit(maxSize: maxSize) // 調用縮放方法
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // 根據圖片的原始大小和最大顯示寬高進行等比縮放
    private func scaleToFit(maxSize: CGSize) {
        let originalSize = self.texture?.size() ?? CGSize(width: 1, height: 1) // 確保讀到圖片的原始大小
        let scaleWidth = maxSize.width / originalSize.width
        let scaleHeight = maxSize.height / originalSize.height
        let finalScale = min(scaleWidth, scaleHeight) // 取較小的縮放比例來保持等比縮放
        self.setScale(finalScale)
    }
}
