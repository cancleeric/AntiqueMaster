//
//  AnimationHelper.swift
//  LifeSnap
//
//  Created by EricWang on 2023/12/26.
//

import SpriteKit

// 動畫處理的基類
class AnimatedSKNode: FrameSKNode {
    // 直接縮放到指定的 scaleY
    func performScalingAnimation(to scale: CGFloat, duration: TimeInterval, completion: (() -> Void)? = nil) {
        let scalingAction = SKAction.scaleY(to: scale, duration: duration)
        self.run(scalingAction) {
            completion?()
        }
    }
    
    func animateToSmall(duration: TimeInterval = 0.2, completion: (() -> Void)? = nil) {
        let scaleDown = SKAction.scale(to: 0.85, duration: duration / 2) // 将持续时间分配给两个动作
        let scaleUp = SKAction.scale(to: 0.9, duration: duration / 2)
        let sequence = SKAction.sequence([scaleDown, scaleUp])
        run(sequence) {
            completion?()
        }
    }
    
    func animateToLarge(duration: TimeInterval = 0.2, completion: (() -> Void)? = nil) {
        let scaleUp = SKAction.scale(to: 1.1, duration: duration / 2) // 将持续时间分配给两个动作
        let scaleDown = SKAction.scale(to: 1.0, duration: duration / 2)
        let sequence = SKAction.sequence([scaleUp, scaleDown])
        run(sequence) {
            completion?()
        }
    }

    func stopAllAnimations() {
        removeAllActions()
        self.xScale = 1
        self.yScale = 1
    }
    
}

extension AnimatedSKNode {
    
    func scale(to scale: CGFloat, duration: TimeInterval, completion: (() -> Void)? = nil) {
        let scaleAction = SKAction.scale(to: scale, duration: duration)
        self.run(scaleAction) {
            completion?()
        }
    }
    
}

extension AnimatedSKNode {

    enum MovementDirection {
        case up, down, left, right
    }

    // General function for movement and fade animation
    func animateMovementAndFade(distance: CGFloat, duration: TimeInterval, direction: MovementDirection, fadeOut: Bool, completion: (() -> Void)? = nil) {
        var moveAction: SKAction
        
        switch direction {
        case .up:
            moveAction = SKAction.moveBy(x: 0, y: distance, duration: duration)
        case .down:
            moveAction = SKAction.moveBy(x: 0, y: -distance, duration: duration)
        case .left:
            moveAction = SKAction.moveBy(x: -distance, y: 0, duration: duration)
        case .right:
            moveAction = SKAction.moveBy(x: distance, y: 0, duration: duration)
        }

        let fadeAction = fadeOut ? SKAction.fadeOut(withDuration: duration) : SKAction.fadeIn(withDuration: duration)
        let group = SKAction.group([moveAction, fadeAction])
        
        self.run(group) {
            completion?()
        }
    }

    // Specific functions for movement with fade effects
    func animateMoveWithFade(distance: CGFloat, duration: TimeInterval = 0.25, direction: MovementDirection, fadeOut: Bool, completion: (() -> Void)? = nil) {
        animateMovementAndFade(distance: distance, duration: duration, direction: direction, fadeOut: fadeOut, completion: completion)
    }
}

extension AnimatedSKNode {
    func startRepeatedScalingAnimation() {
        let scaleUp = SKAction.scale(to: 1.1, duration: 0.2)
        let scaleDown = SKAction.scale(to: 0.9, duration: 0.2)
        let wait = SKAction.wait(forDuration: 0.1) // 你可以调整等待的时间来控制动画的快慢
        
        // 创建一个序列动作，包括放大、缩小和等待
        let sequence = SKAction.sequence([scaleUp, scaleDown, wait])
        
        // 使用.repeatForever(SKAction)将这个序列动作重复执行
        let repeatAction = SKAction.repeatForever(sequence)
        
        // 运行这个重复的动作
        self.run(repeatAction, withKey: "repeatedScalingAnimation") // 给动作一个键名，以便可以随时停止它
    }
}
