import Foundation
import SpriteKit

class GridScene: SKScene {
    var gridNode: GridNode!

    override func didMove(to view: SKView) {
        // 設置背景顏色
        self.backgroundColor = SKColor.black

        // 創建 GridNode 並添加到場景中
        gridNode = GridNode(spacing: 100, lineWidth: 2, lineColor: .red)  // 可以自定義間距、線條寬度和顏色
        gridNode.prepareNode(size: self.size)
        addChild(gridNode)
        gridNode.zPosition = -1  // 將網格置於場景的最底層

        // 打開 FPS 和節點數顯示，便於檢查場景的性能
        self.view?.showsFPS = true
        self.view?.showsNodeCount = true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 點擊螢幕時，切換網格的可見性
        gridNode.toggleVisibility()
    }
}
