//
//  RedBorderNode.swift
//  LifeSnap
//
//  Created by EricWang on 2024/3/10.
//

import SpriteKit

class BorderedNode: SKSpriteNode {
    
    // 圆角半径
    var cornerRadius: CGFloat

    // 初始化方法
    init(
        size: CGSize = CGSize(width: 100, height: 100), cornerRadius: CGFloat = 20,
        lineWidth: CGFloat = 4, fillColor: SKColor = SKColor.clear, borderColor: SKColor = .red
    ) {
        
        self.cornerRadius = cornerRadius
        super.init(texture: nil, color: .clear, size: size)

        // 创建一个CGPath表示圆角矩形
        let path = CGPath(
            roundedRect: CGRect(
                origin: CGPoint(x: -size.width / 2, y: -size.height / 2), size: size),
            cornerWidth: cornerRadius, cornerHeight: cornerRadius, transform: nil)

        // 使用路径创建一个SKShapeNode
        let rectangle = SKShapeNode(path: path)

        // 设置矩形的描边颜色和填充颜色
        rectangle.strokeColor = borderColor
        rectangle.fillColor = fillColor
        rectangle.lineWidth = lineWidth

        // 将矩形添加为当前节点的子节点
        self.addChild(rectangle)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // 添加一个用于执行淡出动画的方法
    func fadeOutAndRemove() {

        let duration = 0.8
        // 创建一个淡出动画SKAction
        let fadeOut = SKAction.fadeOut(withDuration: duration)

        // 创建一个旋转动画SKAction，旋转一圈（2 * π弧度）
        let rotate = SKAction.rotate(byAngle: CGFloat(2 * Double.pi), duration: duration)

        // 创建一个缩小动画SKAction，缩小到0
        let scaleDown = SKAction.scale(to: 0, duration: duration)

        // 创建一个组合动作，同时执行旋转和缩小
        let group = SKAction.group([fadeOut, rotate, scaleDown])

        // 创建一个移除节点的SKAction
        let remove = SKAction.removeFromParent()

        // 创建一个序列动作，先执行组合动画再移除
        let sequence = SKAction.sequence([group, remove])

        // 执行动画序列
        self.run(sequence)
    }

    func fadeOutAndRemove2() {
        let duration = 0.8
        // 创建一个淡出动画SKAction
        let fadeOut = SKAction.fadeOut(withDuration: duration)
        // 执行动画序列
        self.run(fadeOut)

    }

}
