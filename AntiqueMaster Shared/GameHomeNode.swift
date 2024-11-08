//
//  GameHomeNode.swift
//  AntiqueMaster
//
//  Created by EricWang on 2023/7/31.
//  修改於 2024/11/01：新增按鈕顏色設定，調整佈局。
//  修改於 2024/11/04：使用 ComponentFactory 生成節點。

import SpriteKit

/// 管理遊戲首頁 UI 元素的節點
class GameHomeNode: SKNode {
    var playerImageNode: SKSpriteNode?
    var playerNameLabel: OutlinedLabelNode?
    var roomNumberTextField: SKTextFieldNode?  // 新增房號輸入框
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

        ComponentFactory.loadComponentsConfig()
        if ComponentFactory.componentsConfig.isEmpty {
            print("Failed to load or parse JSON data.")
        } else {
            print("Successfully loaded JSON data!")
        }

        // Setup player image
        // playerImageNode =
        //     ComponentFactory.createComponent(named: "playerImage") as? SKSpriteNode
        // guard let playerImageNode = playerImageNode else { return }

        playerNameLabel =
            ComponentFactory.createComponent(named: "playerNameLabel") as? OutlinedLabelNode
        guard let playerNameLabel = playerNameLabel else { return }

        roomNumberTextField =
            ComponentFactory.createComponent(named: "roomNumberTextField") as? SKTextFieldNode
        guard let roomNumberTextField = roomNumberTextField else { return }

        // Setup enter button
        enterButton = ComponentFactory.createComponent(named: "enterButton") as? RoundedButton
        guard let enterButton = enterButton else { return }

        // Arrange player image, name label, room number text field, and enter button horizontally
        let headHStack = HStackNode(containerWidth: availableWidth, spacing: 20, padding: 20)
        headHStack.addElement(ComponentFactory.createComponent(named: "playerImage"))
        headHStack.addElement(playerNameLabel)
        headHStack.addElement(roomNumberTextField)  // 將房號輸入框添加到這裡
        headHStack.addElement(enterButton)  // 將查找房間按鈕添加到這裡
        headHStack.addElement(SpacerNode())
        headHStack.showBorder(color: .blue)

        // Setup other buttons
        let buttonWidth = availableWidth / 6
        let buttonHeight: CGFloat = buttonWidth
        let buttonName = [
            "shopButton", "collectionButton", "appraisalButton", "sectButton", "eventButton",
        ]
        let buttonColors: [(normal: UIColor, dark: UIColor)] = [
            (Colors.ButtonBlock.uiColor, Colors.ButtonBlockDark.uiColor),
            (Colors.ButtonBlue.uiColor, Colors.ButtonBlueDark.uiColor),
            (Colors.ButtonGreen.uiColor, Colors.ButtonGreenDark.uiColor),
            (Colors.ButtonOrange.uiColor, Colors.ButtonOrangeDark.uiColor),
            (Colors.ButtonRed.uiColor, Colors.ButtonRedDark.uiColor),
            (Colors.ButtonYellow.uiColor, Colors.ButtonYellowDark.uiColor),
        ]
        var buttons: [RoundedButton] = []
        for (index, title) in buttonName.enumerated() {
            let button = ComponentFactory.createComponent(named: title) as? RoundedButton
            guard let button = button else { continue }
            buttons.append(button)
        }

        // Arrange buttons horizontally
        let footHStack = HStackNode(containerWidth: availableWidth, spacing: 5, padding: 0)
        footHStack.addElement(SpacerNode())
        footHStack.addElements(buttons)
        footHStack.addElement(SpacerNode())
        footHStack.showBorder(color: .green)

        // Calculate body height
        let headHeight: CGFloat = headHStack.frame.height
        let footHeight: CGFloat = footHStack.frame.height
        let bodyHeight: CGFloat = availableHeight - headHeight - footHeight

        // Setup body buttons
        let startButton = ComponentFactory.createComponent(named: "startButton") as? RoundedButton
        guard let startButton = startButton else { return }

        // 設置 startButton 的 action
        startButton.action = { [weak self] in
            self?.enterGame()
        }

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

    /// 進入遊戲的函式
    func enterGame() {
        print("Entering the game...")
        // 在這裡添加進入遊戲的邏輯
    }

    // Additional methods for button actions can be added here
}
