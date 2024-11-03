//
//  SKTextFieldNode.swift
//  AntiqueMaster
//
//  Created by EricWang on 2024/11/03.
//

import SpriteKit
import UIKit

/// 使用者輸入框節點
///
/// `SKTextFieldNode` 是一個自訂的 `FrameSKNode` 子類別，提供 SpriteKit 場景中的文字輸入功能。當使用者點擊此節點時，會顯示 `TextInputViewController` 來處理文字輸入。
///
/// - Parameters:
///   - placeholder: 佔位文字，用來提示使用者輸入內容
///   - fontSize: 字體大小
///   - fontColor: 字體顏色
///   - backgroundColor: 背景顏色
class SKTextFieldNode: FrameSKNode {
    private var background: SKShapeNode
    private var label: SKLabelNode
    private var placeholder: String
    private var fontSize: CGFloat
    private var fontColor: UIColor
    private var backgroundColor: UIColor
    private var text: String = ""

    init(placeholder: String, fontSize: CGFloat, fontColor: UIColor, backgroundColor: UIColor) {
        self.placeholder = placeholder
        self.fontSize = fontSize
        self.fontColor = fontColor
        self.backgroundColor = backgroundColor

        // 初始化背景節點
        background = SKShapeNode(rectOf: CGSize(width: 300, height: 50), cornerRadius: 10)
        background.fillColor = backgroundColor

        // 初始化標籤節點
        label = SKLabelNode(text: placeholder)
        label.fontSize = fontSize
        label.fontColor = fontColor
        label.verticalAlignmentMode = .center

        super.init()

        self.isUserInteractionEnabled = true
        self.addChild(background)
        self.addChild(label)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) 尚未實作")
    }

    /// 使用 `TextInputViewController` 顯示文字輸入介面
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        showTextInput()
    }

    /// 顯示文字輸入視圖控制器
    private func showTextInput() {
        guard let viewController = self.scene?.view?.window?.rootViewController else { return }

        let textInputVC = TextInputViewController(
            placeholder: placeholder,
            fontSize: fontSize,
            fontColor: fontColor,
            backgroundColor: backgroundColor
        )
        textInputVC.completion = { [weak self] text in
            self?.setText(text)
        }

        viewController.present(textInputVC, animated: true, completion: nil)
    }

    /// 設定文字並更新標籤
    /// - Parameter text: 要設定的文字內容
    func setText(_ text: String) {
        self.text = text
        label.text = text.isEmpty ? placeholder : text
    }

    /// 獲取當前的文字內容
    /// - Returns: 當前的文字
    func getText() -> String {
        return text
    }
}
