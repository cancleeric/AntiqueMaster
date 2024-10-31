//
//  ButtonNode.swift
//  LifeSnap
//
//  Created by EricWang on 2023/7/19.
//

import SpriteKit

//  base button  ， 有基本的使用者輸入，有基本的動畫
class ButtonNode: AnimatedSKNode, CancelableTouch {
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
    
    func setDisabledColors() {}
    func setEnabledColors() {}
     
    override init() {
        super.init()
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var initialTouchPoint: CGPoint = .zero
    private var hasMoved: Bool = false
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            initialTouchPoint = touch.location(in: self)
        }
        removeAllActions()
        animateToSmall()
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currentTouchPoint = touch.location(in: self)
            let distance = sqrt(pow((currentTouchPoint.x - initialTouchPoint.x), 2) + pow((currentTouchPoint.y - initialTouchPoint.y), 2))
            if distance > 5 {
                stopAllAnimations()
                hasMoved = true
            }
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !hasMoved {
            // 呼叫外部提供的回調函數
            DebugLogger.debug(" ButtonNode touchesEnded ")
            
            removeAllActions()
            animateToLarge() {
                self.action?()
            }

        }
        
        hasMoved = false
    }
    
    func touchCancelled() {
        stopAllAnimations()
    }
}

