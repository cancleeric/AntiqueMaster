//
//  GameHomeNode.swift
//  AntiqueMaster
//
//  Created by EricWang on 2023/7/31.
//  修改於 2024/11/01：新增按鈕顏色設定，調整佈局。

import SpriteKit

/// 管理遊戲首頁 UI 元素的節點
class GameHomeNode: SKNode {
    var playerImageNode: SKSpriteNode?
    var playerNameLabel: OutlinedLabelNode?
    var enterButton: RoundedButton?
    var startButton: RoundedButton?
    var settingsButton: RoundedButton?

    // 保存 availableWidth 和 availableHeight
    private var availableWidth: CGFloat = 0.0
    private var availableHeight: CGFloat = 0.0

    /// 設置 GameHomeNode 的各個子節點
    func setupNodes(availableWidth: CGFloat, availableHeight: CGFloat) {
        self.availableWidth = availableWidth
        self.availableHeight = availableHeight

        // Setup player image
        playerImageNode = SKSpriteNode(imageNamed: "logoImage")
        guard let playerImageNode = playerImageNode else { return }
        playerImageNode.size = CGSize(width: 256, height: 256)

        // Setup player name label
        playerNameLabel = OutlinedLabelNode(
            text: "玩家姓名",
            fontSize: 48,
            fontColor: .white,
            outlineColor: .black,
            outlineWidth: 1
        )
        guard let playerNameLabel = playerNameLabel else { return }

        // Setup enter button
        enterButton = RoundedButton(
            text: "查找房間", width: 200, height: 100, fontSize: 48,
            normalColor: Colors.ButtonPurple.uiColor, darkColor: Colors.ButtonPurpleDark.uiColor
        )
        guard let enterButton = enterButton else { return }

        // Arrange player image, name label, and enter button horizontally
        let headHStack = HStackNode(containerWidth: availableWidth, spacing: 20, padding: 20)
        headHStack.addElement(playerImageNode)
        headHStack.addElement(playerNameLabel)
        headHStack.addElement(enterButton)  // 將查找房間按鈕添加到這裡
        headHStack.addElement(SpacerNode())
        headHStack.showBorder(color: .blue)

        // Setup other buttons
        let buttonWidth = availableWidth / 6
        let buttonHeight: CGFloat = buttonWidth
        let buttonTitles = ["商店", "收藏", "鑑寶", "門派", "活動"]
        let buttonColors: [(normal: UIColor, dark: UIColor)] = [
            (Colors.ButtonBlock.uiColor, Colors.ButtonBlockDark.uiColor),
            (Colors.ButtonBlue.uiColor, Colors.ButtonBlueDark.uiColor),
            (Colors.ButtonGreen.uiColor, Colors.ButtonGreenDark.uiColor),
            (Colors.ButtonOrange.uiColor, Colors.ButtonOrangeDark.uiColor),
            (Colors.ButtonRed.uiColor, Colors.ButtonRedDark.uiColor),
            (Colors.ButtonYellow.uiColor, Colors.ButtonYellowDark.uiColor),
        ]
        var buttons: [RoundedButton] = []
        for (index, title) in buttonTitles.enumerated() {
            let button = RoundedButton(
                text: title, width: buttonWidth, height: buttonHeight, fontSize: 48,
                normalColor: buttonColors[index].normal, darkColor: buttonColors[index].dark)
            buttons.append(button)
        }

        // Arrange buttons horizontally
        let footHStack = HStackNode(containerWidth: availableWidth, spacing: 20, padding: 0)
        footHStack.addElement(SpacerNode())
        footHStack.addElements(buttons)
        footHStack.addElement(SpacerNode())
        footHStack.showBorder(color: .green)

        // Calculate body height
        let headHeight: CGFloat = headHStack.frame.height
        let footHeight: CGFloat = footHStack.frame.height
        let bodyHeight: CGFloat = availableHeight - headHeight - footHeight

        // Setup body buttons
        let bodyButtonWidth = 660.0
        let bodyButtonHeight: CGFloat = 220
        let startButton = RoundedButton(
            text: "快速開局", width: bodyButtonWidth, height: bodyButtonHeight, fontSize: 96,
            normalColor: Colors.ButtonYellow.uiColor, darkColor: Colors.ButtonYellowDark.uiColor
        )

        // Arrange body buttons vertically
        let bodyVStack = VStackNode(containerHeight: bodyHeight * 0.98, spacing: 0, padding: 0)
        bodyVStack.addElement(SpacerNode())
        bodyVStack.addElement(SpacerNode())
        bodyVStack.addElement(startButton)
        bodyVStack.addElement(SpacerNode())
        bodyVStack.showBorder(color: .red)

        // Combine head, body, and foot using VStackNode
        let vStack = VStackNode(containerHeight: availableHeight, spacing: 0, padding: 0)
        vStack.addElement(headHStack)
        vStack.addElement(SpacerNode())
        vStack.addElement(bodyVStack)
        vStack.addElement(footHStack)
        vStack.showBorder(color: .black)

        self.addChild(vStack)
    }

    // Additional methods for button actions can be added here
}
