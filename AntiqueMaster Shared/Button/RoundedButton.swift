//
//  RoundedButton.swift
//  LifeSnap
//
//  Created by EricWang on 2023/7/31.
//  Updated on 2024/11/02
//
//  此文件包含 RoundedButton 類別，該類別是一個圓角按鈕，支援顯示文字和圖片，並具有可選的通知徽章。
//  動畫相關的邏輯已經移動到 AnimationHelper 類別中，這裡只負責調用 AnimationHelper 中的方法。
//  根據字體大小設置 outlineWidth，最小值為 1.0

import SpriteKit
import SwiftUI

/// NotificationBadgeNode 是一個圓形的節點，用於顯示通知徽章。
class NotificationBadgeNode: SKShapeNode {
    init(radius: CGFloat) {
        super.init()

        // 創建一個圓形的 SKShapeNode
        self.path =
            UIBezierPath(
                roundedRect: CGRect(x: -radius, y: -radius, width: 2 * radius, height: 2 * radius),
                cornerRadius: radius
            ).cgPath

        // 設置填充顏色為紅色
        self.fillColor = UIColor.red
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// RoundedButton 是一個圓角按鈕，支援顯示文字和圖片，並具有可選的通知徽章。
class RoundedButton: SKShapeNode, CancelableTouch {
    var action: (() -> Void)?
    var disabled: Bool = false {
        didSet {
            // 更新按鈕的外觀或行為
            self.isUserInteractionEnabled = !disabled
            if disabled {
                setDisabledColors()
            } else {
                setEnabledColors()
            }
        }
    }

    let normalColor: UIColor
    let darkColor: UIColor
    let imageTextNode: ImageOutlinedTextNode
    var badgeNode: NotificationBadgeNode
    var isHintShown = false {
        didSet {
            isHintCircle()
        }
    }

    /// 初始化圓角按鈕
    /// - Parameters:
    ///   - text: 按鈕上的文字
    ///   - width: 按鈕的寬度
    ///   - height: 按鈕的高度
    ///   - fontSize: 文字的字體大小
    ///   - normalColor: 按鈕的正常顏色
    ///   - darkColor: 按鈕的深色，用於邊框和文字輪廓
    ///   - image: 按鈕上的圖片名稱（可選）
    ///   - cornerRadius: 按鈕的圓角半徑（可選）
    init(
        text: String, width: CGFloat, height: CGFloat, fontSize: CGFloat = 24,
        normalColor: UIColor = Colors.ButtonPurple.uiColor,
        darkColor: UIColor = Colors.ButtonPurpleDark.uiColor, image: String? = nil,
        cornerRadius: CGFloat? = nil
    ) {

        // 根據字體大小設置 outlineWidth，最小值為 1.0
        let outlineWidth = max(fontSize * 0.05, 1.0)
        imageTextNode = ImageOutlinedTextNode(
            imageName: image ?? "", text: text, fontSize: fontSize, fontColor: .white,
            outlineColor: darkColor, outlineWidth: outlineWidth)
        self.normalColor = normalColor
        self.darkColor = darkColor

        let radius = height / 4
        self.badgeNode = NotificationBadgeNode(radius: radius)
        badgeNode.position = CGPoint(x: -width / 2 + radius, y: height / 2)
        badgeNode.isHidden = !isHintShown

        super.init()

        var uIBezierCornerRadius = height / 2
        if let cornerRadius {
            uIBezierCornerRadius = cornerRadius
        }

        let rect = CGRect(x: -width / 2, y: -height / 2, width: width, height: height)
        let path = UIBezierPath(roundedRect: rect, cornerRadius: uIBezierCornerRadius).cgPath
        self.path = path
        fillColor = normalColor
        strokeColor = darkColor
        lineWidth = 1

        addChild(imageTextNode)
        addChild(badgeNode)

        isUserInteractionEnabled = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 切換 badgeNode 的 hidden 屬性
    func isHintCircle() {
        badgeNode.isHidden = !self.isHintShown
    }

    /// 設置按鈕的禁用顏色
    func setDisabledColors() {
        fillColor = Colors.ButtonBlock.uiColor
        strokeColor = Colors.ButtonBlockDark.uiColor
        imageTextNode.setFontColor(.white)
        imageTextNode.setOutlineColor(Colors.ButtonBlockDark.uiColor)
    }

    /// 設置按鈕的啟用顏色
    func setEnabledColors() {
        fillColor = normalColor
        strokeColor = darkColor
        imageTextNode.setFontColor(.white)
        imageTextNode.setOutlineColor(darkColor)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        AnimationHelper.shared.buttonTouchBeganAnimation(self, darkColor: darkColor)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        AnimationHelper.shared.buttonTouchEndedAnimation(self, normalColor: normalColor)
        animateButton()
    }

    /// 設置按鈕上的文字
    /// - Parameter text: 新的文字
    func setText(_ text: String) {
        self.imageTextNode.setText(text)
    }

    /// 設置按鈕文字的字體大小
    /// - Parameter fontSize: 新的字體大小
    func setLabelFontSize(fontSize: CGFloat) {
        self.imageTextNode.setFontSize(fontSize)
    }

    /// 執行按鈕的動畫效果
    func animateButton() {
        AnimationHelper.shared.buttonPressedAnimation(self) {
            self.action?()
        }
    }

    func touchCancelled() {
        AnimationHelper.shared.buttonTouchCancelledAnimation(
            self, normalColor: normalColor, darkColor: darkColor)
    }
}
