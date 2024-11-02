//
//  AnimationHelper.swift
//  LifeSnap
//
//  Created by EricWang on 2023/12/26.
//  Updated on 2024/11/02
//
//  此文件包含 AnimationHelper 類別，該類別提供了多種動畫方法，
//  包括按鈕的顏色插值動畫、按鈕按下動畫、按鈕觸摸開始動畫、按鈕觸摸結束動畫和按鈕觸摸取消動畫。
//  這些方法從 RoundedButton 類別中移動過來，以集中管理動畫邏輯。

import Foundation
import SpriteKit

class AnimationHelper: AnimatedSKNode {
    // 使用static let确保这个shared实例是唯一的，并且是懒加载的
    static let shared = AnimationHelper()

    // 你可以在这个类中添加更多的方法，或者重写AnimatedSKNode的方法来满足特定的需求
    // 例如，扩展animateNode方法来为外部节点提供动画服务
    func animateNode(
        _ node: SKNode, movementAndFade distance: CGFloat, duration: TimeInterval,
        direction: MovementDirection, fadeOut: Bool, completion: (() -> Void)? = nil
    ) {
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

        let fadeAction =
            fadeOut
            ? SKAction.fadeOut(withDuration: duration) : SKAction.fadeIn(withDuration: duration)
        let group = SKAction.group([moveAction, fadeAction])

        node.run(group, completion: completion ?? {})
    }

    // 添加晃动动画
    func animateWiggle(_ node: SKNode) {
        let scaleUp = SKAction.scale(to: 1.2, duration: 0.3)
        let scaleDown = SKAction.scale(to: 1.0, duration: 0.3)
        let moveLeft = SKAction.moveBy(x: -5, y: 0, duration: 0.1)
        let moveRight = SKAction.moveBy(x: 5, y: 0, duration: 0.1)
        let wiggle = SKAction.sequence([
            moveLeft, moveRight, moveLeft, moveRight, scaleUp, scaleDown,
        ])

        let wait = SKAction.wait(forDuration: 2)  // 等待两秒
        let sequence = SKAction.sequence([wiggle, wait])  // 将等待动作添加到序列中
        let repeatForever = SKAction.repeatForever(sequence)

        node.run(repeatForever)
    }

    func createWiggleAnimation() -> SKAction {
        // 创建晃动动画...
        let scaleUp = SKAction.scale(to: 1.2, duration: 0.3)
        let scaleDown = SKAction.scale(to: 1.0, duration: 0.3)
        let moveLeft = SKAction.moveBy(x: -5, y: 0, duration: 0.1)
        let moveRight = SKAction.moveBy(x: 5, y: 0, duration: 0.1)
        let wiggle = SKAction.sequence([
            moveLeft, moveRight, moveLeft, moveRight, scaleUp, scaleDown,
        ])

        let wait = SKAction.wait(forDuration: 2)  // 等待两秒
        let sequence = SKAction.sequence([wiggle, wait])  // 将等待动作添加到序列中
        let repeatForever = SKAction.repeatForever(sequence)

        return repeatForever
    }

    // 创建并返回一个重复的放大缩小动作
    func createRepeatedScalingAction() -> SKAction {
        let scaleUp = SKAction.scale(to: 1.1, duration: 0.2)
        let scaleDown = SKAction.scale(to: 0.9, duration: 0.2)
        let wait = SKAction.wait(forDuration: 0.2)  // 可以调整等待时间来控制动画速度

        let sequence = SKAction.sequence([scaleUp, scaleDown, wait])
        return SKAction.repeatForever(sequence)
    }

    // 直接对任意SKNode执行重复的放大缩小动画
    func applyRepeatedScalingAnimation(to node: SKNode) {
        let repeatedScalingAction = createRepeatedScalingAction()
        node.run(repeatedScalingAction, withKey: "repeatedScalingAnimation")
    }

    // 新增顏色插值動畫
    func buttonColorInterpolationAnimation(
        _ node: SKShapeNode, from startColor: UIColor, to endColor: UIColor, duration: TimeInterval
    ) {
        let action = SKAction.customAction(withDuration: duration) { node, elapsedTime in
            let progress = elapsedTime / duration
            if let shapeNode = node as? SKShapeNode {
                shapeNode.fillColor = startColor.interpolate(to: endColor, progress: progress)
            }
        }
        node.run(action)
    }

    // 按鈕按下動畫
    func buttonPressedAnimation(_ node: SKNode, completion: (() -> Void)? = nil) {
        let scaleDownAction = SKAction.scale(to: 0.90, duration: 0.08)
        let scaleUpAction = SKAction.scale(to: 1.02, duration: 0.08)
        let scaleNormalAction = SKAction.scale(to: 1.0, duration: 0.08)

        let sequence = SKAction.sequence([scaleDownAction, scaleUpAction, scaleNormalAction])
        node.run(sequence) {
            completion?()
        }
    }

    // 按鈕觸摸開始動畫
    func buttonTouchBeganAnimation(_ node: SKShapeNode, darkColor: UIColor) {
        let action = SKAction.customAction(withDuration: 0.08) { node, elapsedTime in
            if let node = node as? SKShapeNode {
                let progress = elapsedTime / 0.08
                node.fillColor = node.fillColor.interpolate(to: darkColor, progress: progress)
            }
        }
        node.run(action, withKey: "touchesBeganAction")
    }

    // 按鈕觸摸結束動畫
    func buttonTouchEndedAnimation(_ node: SKShapeNode, normalColor: UIColor) {
        node.removeAction(forKey: "touchesBeganAction")

        let action = SKAction.customAction(withDuration: 0.08) { node, elapsedTime in
            if let node = node as? SKShapeNode {
                let progress = elapsedTime / 0.08
                node.fillColor = node.fillColor.interpolate(to: normalColor, progress: progress)
            }
        }
        node.run(action)
    }

    // 按鈕觸摸取消動畫
    func buttonTouchCancelledAnimation(
        _ node: SKShapeNode, normalColor: UIColor, darkColor: UIColor
    ) {
        let action = SKAction.customAction(withDuration: 0.08) { node, elapsedTime in
            if let node = node as? SKShapeNode {
                let progress = elapsedTime / 0.08
                node.fillColor = node.fillColor.interpolate(to: normalColor, progress: progress)
            }
        }
        node.run(action)

        let scaleDownAction = SKAction.scale(to: 0.90, duration: 0.08)
        let scaleUpAction = SKAction.scale(to: 1.02, duration: 0.08)
        let scaleNormalAction = SKAction.scale(to: 1.0, duration: 0.08)

        let sequence = SKAction.sequence([scaleDownAction, scaleUpAction, scaleNormalAction])
        node.run(sequence)
    }
}
