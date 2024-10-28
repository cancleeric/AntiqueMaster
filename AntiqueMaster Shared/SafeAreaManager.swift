//
//  SafeAreaManager.swift
//  AntiqueMaster
//
//  Created by EricWang on 2024/3/4.
//
//  SafeAreaManager 負責管理應用程式中裝置的安全區域（Safe Area Insets）以及可用的螢幕尺寸。
//  它提供了一個集中式的方式來訪問和更新安全區域，並根據安全區域計算可用的螢幕範圍。
//
//  修改記錄:
//  - 2024/10/22: 增加了安全區域的調整功能，並為 SKNode 元素的上下位置提供了考慮安全區域的調整邏輯。
//  - 2024/10/22: 增加了位置計算的便利方法，用來計算根據安全區域調整後的 X 和 Y 座標。
//  - 2024/10/22: 使用繁體中文加入 Xcode 文件說明註解，適應 SwiftUI 開發環境。


import UIKit
import Foundation
import SpriteKit

/// `SafeAreaManager` 是一個單例結構，用來管理應用中的安全區域插入邊距以及可用的螢幕大小。
/// 它提供集中化的方式來存取和更新安全區域，並計算可用的螢幕範圍。
class SafeAreaManager {
    
    /// `SafeAreaManager` 的共享實例
    static let shared = SafeAreaManager()
    
    /// 表示螢幕安全區域插入邊距的屬性
    var safeAreaInsets: UIEdgeInsets = .zero
    
    /// 初始化時，設定為裝置的螢幕尺寸
    var usableScreenSize: CGSize = UIScreen.main.bounds.size
    
    /// 是否開啟 Debug 模式，開啟後會輸出更多的訊息
    var isDebugMode: Bool = false
    
    /// 初始化 `SafeAreaManager` 的新實例。
    /// 此初始化為私有，防止外部實例化，確保單例模式。
    private init() {}
    
    /// 更新螢幕的安全區域插入邊距。
    /// - Parameters:
    ///   - top: 安全區域頂部的插入邊距
    ///   - bottom: 安全區域底部的插入邊距
    ///   - left: 安全區域左側的插入邊距
    ///   - right: 安全區域右側的插入邊距
    func updateSafeAreaInsets(top: CGFloat, bottom: CGFloat, left: CGFloat, right: CGFloat) {
        self.safeAreaInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        // Debug 日誌：當 debug 模式開啟時，輸出安全區域的內距
        debugLog("Updated safe area insets: \(safeAreaInsets)")

    }
    
    /// 更新不包含安全區域插入邊距的可用螢幕區域的大小。
    /// - Parameter size: 可用螢幕區域的新大小。
    func updateUsableScreenSize(size: CGSize) {
        // 首先加上安全區域的尺寸
        var adjustedSize = CGSize(
            width: size.width + safeAreaInsets.left + safeAreaInsets.right,
            height: size.height + safeAreaInsets.top + safeAreaInsets.bottom
        )
        
        // 定義目標最小尺寸
        let minHeight: CGFloat = 845
        let minWidth: CGFloat = 428
        
        // 根據尺寸與最小限定值的比較，決定是縮小還是放大
        if adjustedSize.width < minWidth || adjustedSize.height < minHeight {
            // 放大尺寸
            let widthScale = minWidth / adjustedSize.width
            let heightScale = minHeight / adjustedSize.height
            let scale = max(widthScale, heightScale)
            adjustedSize.width *= scale
            adjustedSize.height *= scale
            // Debug 日誌：當 debug 模式開啟時，輸出放大的比例和結果
            debugLog("Scaled up size: \(adjustedSize), scale factor: \(scale)")

        } else if adjustedSize.width > minWidth && adjustedSize.height > minHeight {
            // 縮小尺寸
            let widthScale = adjustedSize.width / minWidth
            let heightScale = adjustedSize.height / minHeight
            let scale = min(widthScale, heightScale)
            adjustedSize.width /= scale
            adjustedSize.height /= scale
            // Debug 日誌：當 debug 模式開啟時，輸出縮小的比例和結果
            debugLog("Scaled down size: \(adjustedSize), scale factor: \(scale)")

        }
        
        // 最後，減去安全區域的尺寸以得到最終的可用螢幕區域大小
        adjustedSize.width -= safeAreaInsets.left + safeAreaInsets.right
        adjustedSize.height -= safeAreaInsets.top + safeAreaInsets.bottom
        
        // Debug 日誌：輸出調整後的可用屏幕區域
        debugLog("Final usable screen size: \(adjustedSize)")

        // 更新可用螢幕區域大小
        self.usableScreenSize = adjustedSize
    }
    
    // MARK: - Debug 日誌封裝方法
    
    /// 輸出 debug 訊息
    /// - Parameter message: 要輸出的訊息
    private func debugLog(_ message: String) {
        if isDebugMode {
            print("[SafeAreaManager Debug] \(message)")
        }
    }


    /// 取得考慮到安全區域後的可用寬度。
      var availableWidth: CGFloat {
          let width = usableScreenSize.width
          return width > 0 ? width : UIScreen.main.bounds.width
      }

      /// 取得考慮到安全區域後的可用高度。
      var availableHeight: CGFloat {
          let height = usableScreenSize.height
          return height > 0 ? height : UIScreen.main.bounds.height
      }

      /// 計算並返回包括安全區域的全螢幕範圍，用於判斷整個螢幕大小（包括系統UI覆蓋的部分）。
      /// - Returns: `CGRect` 表示包括安全區域的全螢幕範圍。
      func calculateUsableArea() -> CGRect {
          let insets = safeAreaInsets
          let fullSize = CGSize(
              width: usableScreenSize.width + insets.left + insets.right,
              height: usableScreenSize.height + insets.top + insets.bottom
          )
          return CGRect(x: 0, y: 0, width: fullSize.width, height: fullSize.height)
      }

      /// 取得安全區域頂部的高度。
      var topSafeAreaHeight: CGFloat {
          return safeAreaInsets.top
      }

      /// 取得安全區域底部的高度。
      var bottomSafeAreaHeight: CGFloat {
          return safeAreaInsets.bottom
      }

      /// 取得安全區域左側的寬度。
      var leftSafeAreaWidth: CGFloat {
          return safeAreaInsets.left
      }

      /// 取得安全區域右側的寬度。
      var rightSafeAreaWidth: CGFloat {
          return safeAreaInsets.right
      }

      /// 調整給定節點在場景中的位置，確保其不會超出場景邊界，並考慮到安全區域。
      /// - Parameters:
      ///   - node: 要調整的節點。
      ///   - scene: 所屬的場景，根據場景大小調整位置。
      func adjustPosition(of node: SKNode, in scene: SKScene) {
          let sceneSize = scene.size
          var newPosition = node.position

          // 調整位置前輸出節點位置
          debugLog("Original node position: \(node.position)")

          // 調整 Y 座標
          if newPosition.y - (node.frame.height / 2) < bottomSafeAreaHeight {
              newPosition.y = bottomSafeAreaHeight + (node.frame.height / 2)
          } else if newPosition.y + (node.frame.height / 2) > sceneSize.height - topSafeAreaHeight {
              newPosition.y = sceneSize.height - topSafeAreaHeight - (node.frame.height / 2)
          }

          // 調整 X 座標
          if newPosition.x - (node.frame.width / 2) < leftSafeAreaWidth {
              newPosition.x = leftSafeAreaWidth + (node.frame.width / 2)
          } else if newPosition.x + (node.frame.width / 2) > sceneSize.width - rightSafeAreaWidth {
              newPosition.x = sceneSize.width - rightSafeAreaWidth - (node.frame.width / 2)
          }

          // 更新節點的位置
          node.position = newPosition
          // 調整位置後輸出節點的新位置
          debugLog("Adjusted node position: \(node.position)")

      }
}

extension SafeAreaManager {
    /// 調整節點的 Y 軸位置，考慮安全區域。
    /// - Parameters:
    ///   - node: 要調整的節點。
    ///   - idealXPosition: 節點在 X 軸的理想位置。
    ///   - minimumTopSpace: 安全區域上方的最小距離，預設為 45。
    func adjustPositionForTopConsideringSafeArea(node: SKNode, idealXPosition: CGFloat, minimumTopSpace: CGFloat) {
        // 計算考慮安全區域的頂部邊距
        let topMargin = max(topSafeAreaHeight, minimumTopSpace)

        // 調整後的 Y 位置
        let adjustedYPosition = calculateUsableArea().height - topMargin - node.frame.size.height / 2

        // 更新節點位置
        node.position = CGPoint(x: idealXPosition, y: adjustedYPosition)
    }

    /// 計算節點的 Y 軸位置，考慮安全區域。
    /// - Parameters:
    ///   - nodeSize: 節點的尺寸。
    ///   - idealXPosition: 節點在 X 軸的理想位置。
    ///   - minimumTopSpace: 安全區域上方的最小距離，預設為 45。
    /// - Returns: 根據安全區域調整後的 CGPoint 位置。
    func calculateAdjustedPositionConsideringTopSafeArea(nodeSize: CGSize, idealXPosition: CGFloat, minimumTopSpace: CGFloat = 45) -> CGPoint {
        // 計算頂部邊距
        let topMargin = max(topSafeAreaHeight, minimumTopSpace)

        // 可用高度
        let usableHeight = calculateUsableArea().height - topMargin

        // 調整後的 Y 位置
        let adjustedYPosition = usableHeight - nodeSize.height / 2

        return CGPoint(x: idealXPosition, y: adjustedYPosition)
    }
}

extension SafeAreaManager {
    /// 調整節點的 Y 軸位置，考慮安全區域。
    /// - Parameters:
    ///   - node: 要調整的節點。
    ///   - idealXPosition: 節點在 X 軸的理想位置。
    ///   - minimumBottomSpace: 安全區域下方的最小距離，預設為 45。
    func adjustPositionForBottomConsideringSafeArea(node: SKNode, idealXPosition: CGFloat, minimumBottomSpace: CGFloat = 45) {
        // 計算底部邊距
        let bottomMargin = max(bottomSafeAreaHeight, minimumBottomSpace)

        // 調整後的 Y 位置
        let adjustedYPosition = bottomMargin + node.frame.size.height / 2

        // 更新節點位置
        node.position = CGPoint(x: idealXPosition, y: adjustedYPosition)
    }

    /// 計算節點的 Y 軸位置，考慮安全區域。
    /// - Parameters:
    ///   - nodeSize: 節點的尺寸。
    ///   - idealXPosition: 節點在 X 軸的理想位置。
    ///   - minimumBottomSpace: 安全區域下方的最小距離，預設為 45。
    /// - Returns: 根據安全區域調整後的 CGPoint 位置。
    func calculateAdjustedPositionConsideringBottomSafeArea(nodeSize: CGSize, idealXPosition: CGFloat, minimumBottomSpace: CGFloat = 45) -> CGPoint {
        // 計算底部邊距
        let bottomMargin = max(bottomSafeAreaHeight, minimumBottomSpace)

        // 調整後的 Y 位置
        let adjustedYPosition = bottomMargin + nodeSize.height / 2

        return CGPoint(x: idealXPosition, y: adjustedYPosition)
    }
}


