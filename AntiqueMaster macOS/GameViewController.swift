//
//  GameViewController.swift
//  AntiqueMaster macOS
//
//  Created by EricWang on 2024/10/19.
//

import Cocoa
import GameplayKit
import SpriteKit

// 確認是否需要 import 其他模組
// import YourModuleName

class GameViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 設置初始視圖
        let initialView = SKScene(size: self.view.bounds.size)
        initialView.backgroundColor = SKColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0) // 設置與 LaunchScreen 相同的背景色

        // 添加文字標籤
        let label = SKLabelNode(text: "古董的欺詐")
        label.fontSize = 37
        label.fontColor = .black
        label.position = CGPoint(x: initialView.size.width / 2, y: initialView.size.height / 2)
        initialView.addChild(label)

        let skView = self.view as! SKView
        skView.presentScene(initialView)

        skView.ignoresSiblingOrder = true
        skView.showsFPS = true
        skView.showsNodeCount = true

        // 延遲切換到遊戲場景
        // DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
        //     let scene = GameScene.newGameScene()
        //     skView.presentScene(scene, transition: SKTransition.fade(withDuration: 1.0))
        // }
    }

}
