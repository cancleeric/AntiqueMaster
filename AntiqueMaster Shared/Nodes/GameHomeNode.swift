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

        // Arrange player image and name label horizontally
        let headHStack = HStackNode(containerWidth: availableWidth, spacing: 0, padding: 20)
        headHStack.addElement(playerImageNode)
        headHStack.addElement(playerNameLabel)
        headHStack.addElement(SpacerNode())
        headHStack.showBorder(color: .blue)  // 顯示藍色邊框

        // Setup buttons
        let buttonWidth = availableWidth / 6
        let buttonHeight: CGFloat = buttonWidth

        let buttonTitles = ["進入", "開始", "設定", "幫助", "結束"]
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
        footHStack.showBorder(color: .green)  // 顯示綠色邊框

        // Calculate body height
        let headHeight: CGFloat = headHStack.frame.height
        let footHeight: CGFloat = footHStack.frame.height
        let bodyHeight: CGFloat = availableHeight * 0.8 - headHeight - footHeight

        // Setup body buttons
        let bodyButtonWidth = availableWidth * 0.8
        let bodyButtonHeight: CGFloat = bodyHeight * 0.4

        let enterButton = RoundedButton(
            text: "入局", width: bodyButtonWidth, height: bodyButtonHeight, fontSize: 96,
            normalColor: Colors.ButtonPurple.uiColor, darkColor: Colors.ButtonPurpleDark.uiColor)
        let startButton = RoundedButton(
            text: "開局", width: bodyButtonWidth, height: bodyButtonHeight, fontSize: 96,
            normalColor: Colors.ButtonYellow.uiColor, darkColor: Colors.ButtonYellowDark.uiColor)

        // Arrange body buttons vertically
        let bodyVStack = VStackNode(containerHeight: bodyHeight, spacing: 0, padding: 0)
        bodyVStack.addElement(enterButton)
        bodyVStack.addElement(SpacerNode())
        bodyVStack.addElement(startButton)
        bodyVStack.showBorder(color: .red)  // 顯示紅色邊框

        // Combine head, body, and foot using VStackNode
        let vStack = VStackNode(containerHeight: availableHeight, spacing: 0, padding: 20)

        vStack.addElement(headHStack)
        vStack.addElement(bodyVStack)
        vStack.addElement(SpacerNode())
        vStack.addElement(footHStack)

        vStack.showBorder(color: .black)
        self.addChild(vStack)
    }

    // Additional methods for button actions can be added here
}
