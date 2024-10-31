//
//  LaunchViewController.swift
//  AntiqueMaster iOS
//
//  Created by EricWang on 2024/10/21.
//

import SpriteKit
import UIKit

class LaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 設置初始視圖
        let initialView = SKScene(size: self.view.bounds.size)
        initialView.backgroundColor = SKColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)  // 設置與 LaunchScreen 相同的背景色

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
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.transitionToGameViewController()
        }
    }

    private func transitionToGameViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let gameViewController = storyboard.instantiateViewController(
            withIdentifier: "GameViewController") as? GameViewController
        {
            gameViewController.modalTransitionStyle = .crossDissolve
            gameViewController.modalPresentationStyle = .fullScreen
            self.present(gameViewController, animated: true, completion: nil)
        } else {
            print("Error: GameViewController could not be instantiated.")
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
