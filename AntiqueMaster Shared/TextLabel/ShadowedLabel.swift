//
//  ShadowedLabel.swift
//  LifeSnap
//
//  Created by EricWang on 2023/7/27.
//

import SpriteKit

class ShadowedLabel: SKNode {
    let shadowLabel: SKLabelNode
    let label: SKLabelNode
    
    var verticalAlignmentMode: SKLabelVerticalAlignmentMode = .baseline {
          didSet {
              label.verticalAlignmentMode = verticalAlignmentMode
              shadowLabel.verticalAlignmentMode = verticalAlignmentMode
          }
      }
    
    // 將 frame 方法改為一個計算屬性
    override var frame: CGRect {
           // 計算 label 和 shadowLabel 的邊界
           let labelBounds = label.calculateAccumulatedFrame()
           let shadowLabelBounds = shadowLabel.calculateAccumulatedFrame()

           // 返回兩者邊界的聯集，這將是整個 ShadowedLabel 的邊界
           return labelBounds.union(shadowLabelBounds)
       }
    
    // 新增的屬性，用來設定或獲取字體顏色
        var fontColor: UIColor {
            get {
                return label.fontColor ?? .black
            }
            set {
                label.fontColor = newValue
            }
        }
    
    init(text: String, fontSize: CGFloat, fontColor: UIColor = .systemBrown, shadowColor: UIColor = .white) {
        
        self.shadowLabel = SKLabelNode(text: text)
        self.shadowLabel.fontName = "HelveticaNeue-Bold"
        self.shadowLabel.fontSize = fontSize
        self.shadowLabel.fontColor = shadowColor
        self.shadowLabel.position = CGPoint(x: 1, y: -1)
        
        self.label = SKLabelNode(text: text)
        self.label.fontName = "HelveticaNeue-Bold"
        self.label.fontSize = fontSize
        self.label.fontColor = fontColor

        super.init()
        
        addChild(shadowLabel)
        addChild(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setText(text: String) {
            label.text = text
            shadowLabel.text = text
        }
}
