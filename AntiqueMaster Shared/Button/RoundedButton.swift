//
//  RoundedButton.swift
//  LifeSnap
//
//  Created by EricWang on 2023/7/31.
//

import SpriteKit
import SwiftUI



class NotificationBadgeNode: SKShapeNode {
    init(radius: CGFloat) {
        super.init()
        
        // 創建一個圓形的 SKShapeNode
        self.path = UIBezierPath(roundedRect: CGRect(x: -radius, y: -radius, width: 2 * radius, height: 2 * radius), cornerRadius: radius).cgPath
        
        // 設置填充顏色為紅色
        self.fillColor = UIColor.red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

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
//                self.fillColor = disabled ? .gray : normalColor
            }
        }
    
    let normalColor: UIColor
    let darkColor: UIColor
    
    let imageTextNode: ImageOutlinedTextNode
    

    // 將 badgeNode 的宣告改為可選型別
    var badgeNode: NotificationBadgeNode
//    let hintCircle: CircleShapeNode
    
    var isHintShown = false {
        didSet {
            isHintCircle()
        }
    }
    
    init(text: String, width: CGFloat, height: CGFloat, fontSize: CGFloat = 24, normalColor: UIColor = Colors.ButtonPurple.uiColor, darkColor: UIColor = Colors.ButtonPurpleDark.uiColor , image: String? = nil, cornerRadius: CGFloat? = nil) {
        
        imageTextNode = ImageOutlinedTextNode(imageName: image ?? "", text: text, fontSize: fontSize, fontColor: .white, outlineColor: darkColor) // 使用 ImageTextNode 的初始化方法

        self.normalColor = normalColor
        self.darkColor = darkColor
        
        let radius = height/4 //7.0
        
        self.badgeNode = NotificationBadgeNode(radius: radius)
        badgeNode.position = CGPoint(x: -width / 2 + radius, y: height / 2 )
        badgeNode.isHidden = !isHintShown
//        badgeNode.position = CGPoint(x: self.frame.width / 2 - badgeRadius, y: self.frame.height / 2 - badgeRadius)
        
//        let radius = 7.5
//        hintCircle = CircleShapeNode(radius: radius, fillColor: .red, strokeColor: .clear)
//        hintCircle.position = CGPoint(x: -width / 2 + radius, y: height / 2 - radius)
//        hintCircle.isHidden = !isHintShown
        
        super.init()
        
        var uIBezierCornerRadius = height/2
        if let cornerRadius  {
            uIBezierCornerRadius = cornerRadius
        }
        
        let rect = CGRect(x: -width/2, y: -height/2, width: width, height: height)
        let path = UIBezierPath(roundedRect: rect, cornerRadius: uIBezierCornerRadius).cgPath
        self.path = path
        fillColor = normalColor//
        strokeColor = darkColor
        lineWidth = 1
        
        addChild(imageTextNode)
        addChild(badgeNode)
//        setEnabledColors()
        
        isUserInteractionEnabled = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    // 定義一個函式用來切換hintCircle的hidden屬性
    func isHintCircle() {
        // 如果hintCircle是隱藏的，就顯示它，反之亦然
        badgeNode.isHidden = !self.isHintShown
    }
    
    func setDisabledColors() {
        fillColor = Colors.ButtonBlock.uiColor
        strokeColor = Colors.ButtonBlockDark.uiColor
        imageTextNode.setFontColor(.white)
        imageTextNode.setOutlineColor(Colors.ButtonBlockDark.uiColor)
    }
    
    func setEnabledColors() {
         fillColor = normalColor
         strokeColor = darkColor
         imageTextNode.setFontColor(.white)
         imageTextNode.setOutlineColor(darkColor)
     }
    
//    func setBadgeVisibility(visible: Bool) {
//        if visible {
//            // 如果 badgeNode 不存在，則創建並添加它
//            if self.badgeNode == nil {
//                let badgeRadius = 10.0
//                let badgeNode = NotificationBadgeNode(radius: badgeRadius)
//                badgeNode.position = CGPoint(x: self.frame.width / 2 - badgeRadius, y: self.frame.height / 2 - badgeRadius)
//                self.addChild(badgeNode)
//                self.badgeNode = badgeNode
//            }
//        } else {
//            // 如果 badgeNode 存在，則移除它
//            if let badgeNode = self.badgeNode {
//                badgeNode.removeFromParent()
//                self.badgeNode = nil
//            }
//        }
//    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let action = SKAction.customAction(withDuration: 0.08) { node, elapsedTime in
            if let node = node as? SKShapeNode {
                let progress = elapsedTime / 0.08
                node.fillColor = node.fillColor.interpolate(to: self.darkColor, progress: progress)
            }
        }
        run(action, withKey: "touchesBeganAction")
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        removeAction(forKey: "touchesBeganAction")
        
        let action = SKAction.customAction(withDuration: 0.08) { node, elapsedTime in
            if let node = node as? SKShapeNode {
                let progress = elapsedTime / 0.08
                node.fillColor = node.fillColor.interpolate(to: self.normalColor, progress: progress)
            }
        }
        run(action)
        
        animateButton()
        
    }
    
    func setText(_ text: String) {
        self.imageTextNode.setText(text)
    }
    
    func setLabelFontSize(fontSize: CGFloat) {
        self.imageTextNode.setFontSize(fontSize)
    }
    
    func animateButton() {
        // Set the initial scale to 0.90
        //        self.setScale(0.90)
        let scaleDownAction = SKAction.scale(to: 0.90, duration: 0.08)
        let scaleUpAction = SKAction.scale(to: 1.02, duration: 0.08)
        let scaleNomoreAction = SKAction.scale(to: 1.0, duration: 0.08)
        
        let sequence = SKAction.sequence([scaleDownAction,scaleUpAction, scaleNomoreAction])
        run(sequence) {
            
            self.action?()
        }
    }
    
    func touchCancelled() {
        
        
        let action = SKAction.customAction(withDuration: 0.08) { node, elapsedTime in
            if let node = node as? SKShapeNode {
                let progress = elapsedTime / 0.08
                node.fillColor = node.fillColor.interpolate(to: self.normalColor, progress: progress)
            }
        }
        run(action)
        
        
        let scaleDownAction = SKAction.scale(to: 0.90, duration: 0.08)
        let scaleUpAction = SKAction.scale(to: 1.02, duration: 0.08)
        let scaleNomoreAction = SKAction.scale(to: 1.0, duration: 0.08)
        
        let sequence = SKAction.sequence([scaleDownAction,scaleUpAction, scaleNomoreAction])
        run(sequence)
    }
    
}

