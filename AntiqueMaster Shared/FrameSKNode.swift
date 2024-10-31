import SpriteKit

protocol CustomFrameCalculable {
    /// 计算并返回节点的有效框架大小。
    /// 这应该是考虑到任何遮罩或其他条件后的可见区域的大小。
    var customFrame: CGRect { get }
}

/// `FrameSKNode` 是一個自訂的 SKNode 子類別，用來處理節點的邊框與大小
/// 當節點具有遮罩時，`calculateAccumulatedFrame` 可能無法正確取得節點的大小，因此需要小心處理。
class FrameSKNode: SKNode {
    /// 覆寫 frame 屬性，根據是否符合 `CustomFrameCalculable` 協定來決定回傳自訂的框架大小或是使用預設的計算方式。
    override var frame: CGRect {
        // 檢查當前物件是否符合 CustomFrameCalculable 協定
        if let selfCustomFrame = self as? CustomFrameCalculable {
            // 回傳自訂框架大小
            return selfCustomFrame.customFrame
        } else {
            // 若無遮罩則回傳累積計算的框架
            return self.calculateAccumulatedFrame()
        }
    }

    /// 顯示節點的邊框，預設顏色為紅色`
    /// - Parameter color: 邊框顏色，預設為紅色
    func showBorder(color: UIColor = .red) {
        // 使用當前節點的大小來建立邊框節點
        addChild(BorderedNode(size: self.frame.size, borderColor: color))
    }
}
