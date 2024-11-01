//
//  extensionUIColor.swift
//  LifeSnap
//
//  Created by EricWang on 2023/7/31.
//

import SwiftUI

/**
 這是一個 UIColor 的擴展，它添加了一個名為 interpolate 的方法。該方法接受一個結束顏色和一個進度值作為參數，並返回一個新的顏色，該顏色是起始顏色和結束顏色之間的插值。

 首先，該方法使用 getRed(_:green:blue:alpha:) 方法來獲取起始顏色和結束顏色的紅、綠和藍分量。然後，它根據進度值計算新顏色的紅、綠和藍分量。最後，它使用這些新的分量值創建並返回一個新的 UIColor 對象。
 */
extension UIColor {
    // 定義 interpolate 方法
    func interpolate(to endColor: UIColor, progress: CGFloat) -> UIColor {
        // 定義變量來存儲起始顏色的紅、綠和藍分量
        var startRed: CGFloat = 0
        var startGreen: CGFloat = 0
        var startBlue: CGFloat = 0
        // 使用 getRed 方法來獲取起始顏色的紅、綠和藍分量
        self.getRed(&startRed, green: &startGreen, blue: &startBlue, alpha: nil)
        
        // 定義變量來存儲結束顏色的紅、綠和藍分量
        var endRed: CGFloat = 0
        var endGreen: CGFloat = 0
        var endBlue: CGFloat = 0
        // 使用 getRed 方法來獲取結束顏色的紅、綠和藍分量
        endColor.getRed(&endRed, green: &endGreen, blue: &endBlue, alpha: nil)
        
        // 根據進度值計算新顏色的紅、綠和藍分量
        let newRed = startRed + (endRed - startRed) * progress
        let newGreen = startGreen + (endGreen - startGreen) * progress
        let newBlue = startBlue + (endBlue - startBlue) * progress
        // 創建並返回一個新的 UIColor 對象
        return UIColor(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
}
