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

import GameplayKit
import SpriteKit
import UIKit

class GameViewController: UIViewController {

    // 視圖加載時執行
    override func viewDidLoad() {
        super.viewDidLoad()
        SafeAreaManager.shared.isDebugMode = true

    }

    // 視圖佈局完成後會被調用
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // 這裡保證在佈局完成後抓取安全區域的值
        if #available(iOS 11.0, *) {
            let safeAreaInsets = self.view.safeAreaInsets
            SafeAreaManager.shared.updateSafeAreaInsets(
                top: safeAreaInsets.top,
                bottom: safeAreaInsets.bottom,
                left: safeAreaInsets.left,
                right: safeAreaInsets.right
            )
        }

        // 設置初始視圖
        let initialView = SKScene(size: self.view.bounds.size)
        initialView.backgroundColor = SKColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)  // 設置與 LaunchScreen 相同的背景色

        // 添加 logo 圖像
        let logoImage = SKSpriteNode(imageNamed: "logoImage")
        logoImage.size = CGSize(width: 100, height: 100)  // 設置圖像大小為 100x100
        logoImage.position = CGPoint(x: initialView.size.width / 2, y: initialView.size.height / 2)  // 設置位置在中心
        initialView.addChild(logoImage)

        // 添加文字標籤
        let label = SKLabelNode(text: "古董的欺詐")
        label.fontSize = 37
        label.fontColor = .black
        label.horizontalAlignmentMode = .center  // 設置水平置中
        label.position = CGPoint(
            x: initialView.size.width / 2, y: initialView.size.height / 2 - logoImage.size.height)
        initialView.addChild(label)

        let skView = self.view as! SKView
        skView.presentScene(initialView)

        skView.ignoresSiblingOrder = true
        skView.showsFPS = true
        skView.showsNodeCount = true

        // 延遲切換到遊戲場景
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.transitionToGameScene()
        }
    }

    /// 設置場景，根據當前屏幕尺寸和安全區域進行動態調整
    private func setupScene() {
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
        scene.scaleMode = .aspectFill  // 保持比例，不變形

        // 根據安全區域進行調整
        adjustSceneForSafeArea(scene: scene, scale: finalScale)

        // 顯示場景
        let skView = self.view as! SKView
        skView.presentScene(scene)

        // 忽略節點顯示順序，優化性能
        skView.ignoresSiblingOrder = true
        skView.showsFPS = true  // 顯示每秒幀數
        skView.showsNodeCount = true  // 顯示場景中的節點數量
    }

    /// 根據安全區域動態調整場景的內容
    func adjustSceneForSafeArea(scene: SKScene, scale: CGFloat) {
        // 首先根據縮放比例縮放安全區域的內距
        let safeAreaInsets = SafeAreaManager.shared.safeAreaInsets

        SafeAreaManager.shared.updateSafeAreaInsets(
            top: safeAreaInsets.top * scale,
            bottom: safeAreaInsets.bottom * scale,
            left: safeAreaInsets.left * scale,
            right: safeAreaInsets.right * scale
        )

    }

    // 設置支持的螢幕方向，僅支持縱向
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    // 隱藏狀態列
    override var prefersStatusBarHidden: Bool {
        return true
    }

    /// 切換到遊戲場景
    private func transitionToGameScene() {
        setupScene()
    }
}
