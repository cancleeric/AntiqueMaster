//
//  GameViewController.swift
//  AntiqueMaster iOS
//
//  Created by EricWang on 2024/10/19.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // 設置固定場景大小為縱向
//        let scene = GameScene(size: CGSize(width: 1080, height: 1920)) // 固定解析度 1080x1920，縱向
//        scene.scaleMode = .aspectFill // 保持比例，不變形
//
//
//        // Present the scene
//        let skView = self.view as! SKView
//        skView.presentScene(scene)
//        
//        skView.ignoresSiblingOrder = true
//        skView.showsFPS = true
//        skView.showsNodeCount = true
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 設置最小寬高值
        let minWidth: CGFloat = 428
        let minHeight: CGFloat = 845
        
        // 取得設備的螢幕尺寸
        var screenSize = view.bounds.size
        if screenSize == .zero {
            screenSize = UIScreen.main.bounds.size
        }

        // 計算寬度和高度的縮放比例
        let widthScale = screenSize.width / minWidth
        let heightScale = screenSize.height / minHeight
        
        // 選擇縮放比例較小的來確保不變形
        let scale = min(widthScale, heightScale)
        
        // 計算應用縮放後的寬度和高度
        let scaledWidth = minWidth * scale
        let scaledHeight = minHeight * scale
        
        // 設置場景大小為動態計算出的值
        let scene = GameScene(size: CGSize(width: scaledWidth, height: scaledHeight))
        scene.scaleMode = .aspectFill // 保持比例，不變形

        // Present the scene
        let skView = self.view as! SKView
        skView.presentScene(scene)
        
        skView.ignoresSiblingOrder = true
        skView.showsFPS = true
        skView.showsNodeCount = true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait // 確保僅支持縱向
//        if UIDevice.current.userInterfaceIdiom == .phone {
//            return .allButUpsideDown
//        } else {
//            return .all
//        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
