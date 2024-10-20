//
//  DeviceLayer.swift
//  AntiqueMaster
//
//  Created by EricWang on 2024/10/20.
//

import UIKit
import SpriteKit

class DeviceLayer {
    var screenSize: CGSize
    
    init(view: SKView) {
        self.screenSize = view.bounds.size
    }
    
    func getScreenSize() -> CGSize {
        return screenSize
    }
}


class SafeAreaLayer {
    private var safeAreaInsets: UIEdgeInsets
    
    init(view: SKView) {
        if #available(iOS 11.0, *) {
            self.safeAreaInsets = view.safeAreaInsets
        } else {
            self.safeAreaInsets = UIEdgeInsets.zero
        }
    }
    
    // 獲取安全區域的可用範圍
    func getSafeAreaFrame(for view: SKView) -> CGRect {
        let screenSize = view.bounds.size
        let availableWidth = screenSize.width - (safeAreaInsets.left + safeAreaInsets.right)
        let availableHeight = screenSize.height - (safeAreaInsets.top + safeAreaInsets.bottom)
        return CGRect(x: safeAreaInsets.left, y: safeAreaInsets.bottom, width: availableWidth, height: availableHeight)
    }
}

class GameLayer: SKNode {
    var safeAreaFrame: CGRect
    
    init(safeAreaFrame: CGRect) {
        self.safeAreaFrame = safeAreaFrame
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 初始化遊戲場景內容，將內容放置在安全區域內
    func setupGameScene() {
        self.position = CGPoint(x: safeAreaFrame.midX, y: safeAreaFrame.midY)
        
        // 添加遊戲內容，例如銅像
        let zodiacNames = ["Rat", "Ox", "Tiger", "Rabbit", "Dragon", "Snake", "Horse", "Goat", "Monkey", "Rooster", "Dog", "Pig"]
        
        // 排列內容到遊戲場景中
        for name in zodiacNames {
            let statue = SKSpriteNode(imageNamed: name)
            statue.setScale(0.3)
            statue.position = CGPoint(x: safeAreaFrame.midX, y: safeAreaFrame.midY) // 根據需要調整位置
            self.addChild(statue)
        }
    }
}
