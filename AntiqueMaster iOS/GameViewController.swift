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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 設置固定場景大小為縱向
        let scene = GameScene(size: CGSize(width: 1080, height: 1920)) // 固定解析度 1080x1920，縱向
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
