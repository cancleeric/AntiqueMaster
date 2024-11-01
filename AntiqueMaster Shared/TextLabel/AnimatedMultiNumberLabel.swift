//
//  AnimatedMultiNumberLabel.swift
//  LifeSnap
//
//  Created by EricWang on 2024/1/22.
//

import SpriteKit

class AnimatedNumberLabel: SKNode {
    private var currentValue: Int = 0
    private var targetValue: Int = 0
    private var numberLabels: [ShadowedLabel] = []
    private let labelFontSize: CGFloat
    private let totalAnimationDuration: TimeInterval = 0.5 // 总动画持续时间
    var centerPosition: CGPoint  //= CGPoint(x: 0, y: 0 - labelFontSize/2 + 2)   // 中心位置
    override var frame: CGRect {
        var calculatedFrame = numberLabels[0].calculateAccumulatedFrame()
        // 减小宽度
        calculatedFrame.size.width -= 3
        return calculatedFrame
    }
    
    var animationCompletion: (() -> Void)?
    
    init(fontSize: CGFloat = 32, fontColor: UIColor = .black, shadowColor: UIColor = .white) {
        self.labelFontSize = fontSize
        self.centerPosition =  .zero //CGPoint(x: 0, y: 0 - labelFontSize/2 + 4)
        super.init()
        
        // 創建數字標籤 0 到 9
        for i in 0...9 {
            let label = ShadowedLabel(text: "\(i)", fontSize: fontSize)

//            let label = SKLabelNode(fontNamed: "HelveticaNeue-Bold")
            label.setText(text: "\(i)")
//            label.setFontSize(labelFontSize) //fontSize = labelFontSize
            label.alpha = 0 // 初始化時不顯示
            
//            label.fontColor = fontColor
            label.verticalAlignmentMode = .baseline
            numberLabels.append(label)
        }
        
        // 初始化，設定當前值的標籤可見
//        numberLabels[currentValue].alpha = 1.0
        numberLabels[currentValue].position = centerPosition
        
        let maskSizeFrame = numberLabels[currentValue].calculateAccumulatedFrame()
        
        self.centerPosition = CGPoint(x: 0, y: 0 - maskSizeFrame.height/2)

        // 创建遮罩节点
        let maskNode = SKShapeNode(rectOf: maskSizeFrame.size)
        maskNode.fillColor = .black

        // 创建并设置 SKCropNode
        let cropNode = SKCropNode()
        cropNode.maskNode = maskNode
        addChild(cropNode)
        
        for label in numberLabels {
            cropNode.addChild(label)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setValueImmediately(to newValue: Int) {
        // 停止所有动画
        removeAllActions()
        for label in numberLabels {
            label.removeAllActions()
        }
        
        // 将所有标签移动到初始位置并隐藏
        let initialPosition = CGPoint(x: 0, y: -20 - labelFontSize/2)
        for label in numberLabels {
            label.position = initialPosition
            label.alpha = 0
        }

        // 更新当前值并显示新的目标标签
        currentValue = newValue % 10 // 确保值在0到9之间
        let targetLabel = numberLabels[currentValue]
        targetLabel.position = centerPosition
        targetLabel.alpha = 1.0

        // 重置动画状态和待定目标值
//        isAnimating = false
//        pendingTargetValue = nil
    }
    
    var isAnimating = false  // 用于跟踪动画状态
//    private var pendingTargetValue: Int?  // 存储等待播放的新目标值

    func startAnimation(targetValue: Int) {
//        setValueImmediately(to: self.targetValue)
//
        if isAnimating {
            // 如果当前正在进行动画，则记录新目标值
//            pendingTargetValue = targetValue
//            return
            setValueImmediately(to: self.targetValue)
        }
//
//        // 开始新动画
        isAnimating = true
        executeAnimation(to: targetValue)
    }

    private func executeAnimation(to targetValue: Int) {
//        isAnimating = true
        self.targetValue = targetValue
        
        let initialPosition = CGPoint(x: 0, y: -20 - labelFontSize/2) // 初始位置
//        let centerPosition = CGPoint(x: 0, y: 0 - labelFontSize/2 + 2)   // 中心位置
        let finalPosition = CGPoint(x: 0, y: 20 - labelFontSize/2)   // 最终位置
        

        let animationCount: Int
        if targetValue == currentValue {
            // 如果目标值和当前值相同，则执行一整圈动画
//
            if   numberLabels[currentValue].alpha  == 0 {
                animationCount = 10
            } else {
                numberLabels[currentValue].alpha = 1.0
                return
            }
    
        } else {
            // 否则，计算需要执行动画的次数
            animationCount = targetValue >= currentValue ?
            targetValue - currentValue :
            (10 - currentValue) + targetValue
        }
        
        
        // 计算每个动画步骤的持续时间
        let singleAnimationDuration = totalAnimationDuration / TimeInterval(animationCount)

        let moveIn = SKAction.move(to: centerPosition, duration: singleAnimationDuration)
        let moveUp = SKAction.move(to: finalPosition, duration: singleAnimationDuration)
        let moveDown = SKAction.move(to: initialPosition, duration: 0) // 瞬间移动到初始位置

        let fadeIn = SKAction.fadeIn(withDuration: singleAnimationDuration)
        let fadeOut = SKAction.fadeOut(withDuration: singleAnimationDuration)



        var delayTime: TimeInterval = 0
        
        for i in 0..<animationCount {
            let nextValue = (currentValue + 1) % 10
            let currentLabel = numberLabels[currentValue % 10]
            let nextLabel = numberLabels[nextValue]

            nextLabel.position = CGPoint(x: 0, y: -20)
            nextLabel.alpha = 0

            let delay = SKAction.wait(forDuration: delayTime)
            let currentLabelMoveUp = SKAction.group([moveUp, fadeOut])
            let nextLabelMoveUp = SKAction.group([moveDown, fadeIn, moveIn])

            currentLabel.run(SKAction.sequence([delay, currentLabelMoveUp]))
//            nextLabel.run(SKAction.sequence([delay, nextLabelMoveUp]))

            
            // 检查是否是最后一个动画步骤
            if i == animationCount - 1 {
                nextLabel.run(SKAction.sequence([delay, nextLabelMoveUp])) {
                    [weak self] in
                       guard let self = self else { return }
                       self.isAnimating = false

                       // 检查是否有新目标值需要开始动画
//                       if let newTarget = self.pendingTargetValue {
//                           self.pendingTargetValue = nil
//                           self.executeAnimation(to: newTarget)
//                       } else {
//                           self.animationCompletion?()
//                       }
                }
            } else {
                nextLabel.run(SKAction.sequence([delay, nextLabelMoveUp]))
            }
            
            currentValue = nextValue

            // 更新延时时间
            delayTime += singleAnimationDuration
        }
    }

}

class AnimatedMultiNumberLabel: FrameSKNode {
    private var numberLabels: [SKNode] = []
    private let fontSize: CGFloat
    private var formattedTargetNumber: String = ""
    
    init(fontSize: CGFloat = 32) {
        self.fontSize = fontSize
        super.init()
        // 初始时只显示一位数字
        addNumberLabels(for: ["0"])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimation(targetNumber: Int) {
        
        formattedTargetNumber = formatNumberWithComma(number: targetNumber)
        let characters = Array(formattedTargetNumber)
        // 根据新的目标数字更新标签数量（包括逗号）
        addNumberLabels(for: characters)
        for (index, character) in characters.enumerated() {

            if let digit = Int(String(character)) {
                if let numberLabel = numberLabels[index] as? AnimatedNumberLabel {
//                    numberLabels[index].alpha = 1.0
                    numberLabel.startAnimation(targetValue: digit)
                }
            } else {
                // 对于非数字字符（如逗号），执行淡入动画
//                let fadeInAction = SKAction.fadeIn(withDuration: 0.5)
//                numberLabels[index].run(fadeInAction)
            }
            
            let fadeInAction = SKAction.fadeIn(withDuration: 0.5)
            numberLabels[index].run(fadeInAction)
        }
    }
    
    func setValueImmediately(to targetNumber: Int) {
        formattedTargetNumber = formatNumberWithComma(number: targetNumber)
        let characters = Array(formattedTargetNumber)

        // 根据新的目标数字更新标签数量（包括逗号）
        addNumberLabels(for: characters)

        for (index, character) in characters.enumerated() {
            if let digit = Int(String(character)), let numberLabel = numberLabels[index] as? AnimatedNumberLabel {
                // 对于数字标签，使用 setValueImmediately 设置值
                numberLabel.setValueImmediately(to: digit)
            } else {
                // 对于非数字字符（如逗号），直接设置其可见性
                numberLabels[index].alpha = 1.0
            }
//            numberLabels[index].alpha = 1.0
        }
    }

    
    private func addNumberLabels(for characters: [Character]) {
        // 如果现有的标签数量多于需要的，移除多余的标签
        //        while numberLabels.count > characters.count {
        //            let labelToRemove = numberLabels.removeLast()
        //            labelToRemove.removeFromParent()
        //        }
        
        if numberLabels.count != characters.count {
            while !numberLabels.isEmpty {
                let labelToRemove = numberLabels.removeLast()
                labelToRemove.removeFromParent()
            }
            
            // 如果需要更多的标签，则添加新的标签
            // 添加或更新标签以匹配新的字符序列
            
            //        let reversedCharacters = characters.reversed()
            
            for (index, character) in characters.enumerated() {
                if index >= numberLabels.count {
                    // 创建新标签
                    //                    if CharacterSet.decimalDigits.contains(Unicode.Scalar(String(character))!) {
                    if Int(String(character)) != nil {
                        let numberLabel = AnimatedNumberLabel(fontSize: fontSize)
                        numberLabels.append(numberLabel)
                        numberLabel.alpha = 0.0
                        addChild(numberLabel)
                    } else {
                        // 不是数字，添加普通 SKLabelNode 作为逗号
                        let commaLabel = ShadowedLabel(text: String(character), fontSize: fontSize)
                        commaLabel.verticalAlignmentMode = .top
                        numberLabels.append(commaLabel)
                        commaLabel.alpha = 0.0
                        addChild(commaLabel)
                    }
                }
            }
        }
        
        layoutNumberLabels()
    }

    private func layoutNumberLabels() {
        let labelSpacing: CGFloat = 0 // Normal spacing between labels

        // Calculate total width of all labels
        let totalWidth = numberLabels.reduce(0) { $0 + $1.frame.size.width + labelSpacing } - labelSpacing

        // Starting position
        var currentPositionX = -totalWidth / 2

        for label in numberLabels {
            // Set the position of each label
            label.position = CGPoint(x: currentPositionX + label.frame.size.width / 2, y: 0)
            
            // 根据标签类型来调整位置
            if label is AnimatedNumberLabel {
                label.position = CGPoint(x: currentPositionX + label.frame.size.width / 2, y: 0)
                //                            label.position = CGPoint(x: currentPositionX, y: 0)
            } else {
                label.position = CGPoint(x: currentPositionX + label.frame.size.width / 2, y: -2 )
                //                            currentPositionX += label.frame.size.width / 2
                //                            label.position = CGPoint(x: currentPositionX, y:  0 - label.frame.size.height/2 + 2 )
            }

            
            
            // Update currentPositionX for the next label
            currentPositionX += label.frame.size.width + labelSpacing
        }
    }
//    private func layoutNumberLabels() {
//        let labelSpacing: CGFloat = 0 // 标签之间的正常间距
////        let extraSpacing: CGFloat = 4 // 每三个数字后的额外间隔
//        var currentPositionX: CGFloat = 0
////        var digitCounter = 0
//
//        for label in numberLabels.reversed() {
//
//            // 根据标签类型来调整位置
//            if label is AnimatedNumberLabel {
//                label.position = CGPoint(x: currentPositionX, y: 0)
//            } else {
//                currentPositionX += label.frame.size.width / 2
//                label.position = CGPoint(x: currentPositionX, y:  0 - label.frame.size.height/2 + 2 )
//            }
////            currentPositionX -= label.frame.size.width + labelSpacing
//
//
//            // 根据标签类型来调整位置
//            if label is AnimatedNumberLabel {
//                // 对于数字标签，正常移动位置并计数
//                currentPositionX -= label.frame.size.width + labelSpacing
//
//            } else if label is ShadowedLabel {
//                // 对于逗号标签，仅移动位置
//                currentPositionX -= ( label.frame.size.width * 1.4 ) + labelSpacing
////                DebugLogger.debug("index:currentPositionX \(currentPositionX) \(label.frame.size.width)")
//            }
//        }
//
//    }

    private func formatNumberWithComma(number: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: number)) ?? "\(number)"
    }
}

//    private func addNumberLabels(for digitCount: Int) {
//        // 如果现有的标签数量多于需要的，移除多余的标签
//        while numberLabels.count > digitCount {
//            let labelToRemove = numberLabels.removeLast()
//            labelToRemove.removeFromParent()
//        }
//
//        // 如果需要更多的标签，则添加新的标签
//        while numberLabels.count < digitCount {
//            let numberLabel = AnimatedNumberLabel(fontSize: fontSize)
//            numberLabels.append(numberLabel)
//            addChild(numberLabel)
//        }
//
//        layoutNumberLabels()
//    }
    

//    func startAnimation(targetNumber: Int) {
//        let characters = Array(String(targetNumber))
//        let characterCount = characters.count
//
//        // 根据新的目标数字更新标签数量
//        addNumberLabels(for: characterCount)
//
//        for (index, character) in characters.enumerated() {
//            if let digit = Int(String(character)) {
//                numberLabels[index].startAnimation(targetValue: digit)
//            }
//        }
//    }

//        for label in numberLabels.reversed() {
//            label.position = CGPoint(x: currentPositionX, y: 0)
//
//            currentPositionX -= label.frame.size.width + labelSpacing
//            digitCounter += 1
//
//            // 每三个数字后添加额外间隔
//            if digitCounter % 3 == 0 {
//                currentPositionX -= extraSpacing
//            }
//        }

          // 如果需要更多的标签，则添加新的标签
//            for character in characters.reversed() { // 反转字符数组
//                // 创建新标签
//                if CharacterSet.decimalDigits.contains(Unicode.Scalar(String(character))!) {
//                    // 是数字，添加 AnimatedNumberLabel
//                    let numberLabel = AnimatedNumberLabel(fontSize: fontSize)
//                    numberLabels.insert(numberLabel, at: 0) // 在数组前端插入
//                    addChild(numberLabel)
//                } else {
//                    // 不是数字，添加普通 SKLabelNode 作为逗号
//                    let commaLabel = SKLabelNode(fontNamed: "HelveticaNeue-Bold")
//                    commaLabel.fontSize = fontSize
//                    commaLabel.color = .blue
//                    commaLabel.text = String(character)
//                    numberLabels.insert(commaLabel, at: 0) // 在数组前端插入
//                    addChild(commaLabel)
//                }
//            }
