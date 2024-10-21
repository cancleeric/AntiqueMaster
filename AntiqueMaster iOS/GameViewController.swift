//
//  GameViewController.swift
//  AntiqueMaster iOS
//
//  Created by EricWang on 2024/10/19.
//  修改日期：2024/10/21
//  本次修改：
//  1. 移除多餘的註解，保持程式碼簡潔。
//  2. 加入繁體中文的說明文件，增加可讀性。
//  3. 動態計算場景大小，根據螢幕尺寸進行適當縮放。
//  4. 設置場景為縱向顯示，並隱藏狀態列。

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    // 視圖加載時執行
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 設置目標寬度
        let targetWidth: CGFloat = 1080
          
        // 取得設備的螢幕尺寸
        var screenSize = view.bounds.size
        if screenSize == .zero {
            screenSize = UIScreen.main.bounds.size
        }

        // 計算寬度的縮放比例（無論設備大小，均考慮縮放可能性）
        let widthScale = screenSize.width / targetWidth
          
        // 根據寬度縮放比例決定放大或縮小
        let finalScale = widthScale < 1 ? 1 / widthScale : widthScale

        // 計算縮放後的寬度與高度
        let scaledWidth = screenSize.width * finalScale
        let scaledHeight = screenSize.height * finalScale
        
        // 動態設置場景大小
        let scene = GameScene(size: CGSize(width: scaledWidth, height: scaledHeight))
        scene.scaleMode = .aspectFill // 保持比例，不變形

        // 顯示場景
        let skView = self.view as! SKView
        skView.presentScene(scene)
        
        // 忽略節點顯示順序，優化性能
        skView.ignoresSiblingOrder = true
        skView.showsFPS = true // 顯示每秒幀數
        skView.showsNodeCount = true // 顯示場景中的節點數量
    }
    
    // 設置支持的螢幕方向，僅支持縱向
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    // 隱藏狀態列
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
