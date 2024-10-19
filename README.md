
# AntiqueMaster - iOS 應用程式

Notes:
- Core logic for role assignment, voting, and round management completed.
- Images are dynamically scaled to fit the screen.

TODO:
- Handle safe area insets to ensure UI elements are not obstructed by notches or system UI.
- Refine the layout for different screen sizes, especially in vertical mode.
- Implement local multiplayer support using Bluetooth/Wi-Fi.
- Add more characters and extend game logic to support them."

## 簡介

AntiqueMaster 是一款專為桌遊《古董的欺詐 - 十二生肖銅像》設計的 iOS 應用程式。此應用協助玩家管理遊戲設置、回合流程及規則執行，並提供數位化的平臺來進行角色分配、投票與計分，讓遊戲更加流暢。

## 功能

1. 角色分配：根據玩家人數隨機分配角色（鑑定者與偽造者）。
2. 輪次與回合管理：自動管理遊戲流程，包括收入、鑑定、討論與投票階段。
3. 投票系統：玩家可針對銅像的真偽進行投票，應用程式會跟蹤並揭示投票結果。
4. 計分與勝利條件：根據遊戲結果計算勝利分數（VP），並宣布獲勝陣營。
5. 角色技能：整合每個角色的特殊技能，增添遊戲策略深度。

## 設置

1. 從 App Store 下載應用程式（或在開發期間通過 Xcode 安裝）。
2. 啟動應用程式，並輸入玩家人數。
3. 應用程式將隨機分配角色，並引導玩家完成設置過程，包括角色選擇。

## 遊戲流程

遊戲共進行三輪，每輪包含四個階段：

1. **收入階段**：玩家收集籌碼。
2. **鑑定階段**：玩家依次對銅像進行鑑定，並使用角色技能。
3. **討論階段**：玩家討論鑑定結果，並推測銅像的真偽。
4. **投票階段**：玩家對希望保留的銅像進行投票，應用程式將跟蹤並揭示投票結果。

## 開發

本項目使用 Swift 和 SpriteKit 開發，負責遊戲的圖形呈現和互動。核心邏輯包括：

- **圖像縮放與佈局**：使用 `ScaledSpriteNode` 類別，繼承自 `SKSpriteNode`，實現圖片的等比縮放與佈局。
- **佈局管理**：使用 `VStackNode` 和 `HStackNode` 負責將圖片按行列排列，確保銅像在螢幕上均勻顯示。

### 主要類別：

1. **`ScaledSpriteNode`**：繼承自 `SKSpriteNode`，負責根據最大顯示範圍計算並應用等比縮放。
2. **`VStackNode` 和 `HStackNode`**：用來垂直和水平排列銅像，實現 3x4 的佈局設計。

### 使用技術：

- **SpriteKit**：負責遊戲畫面呈現與動態效果。
- **Swift**：負責邏輯編寫與應用整體開發。

## 計劃功能（未來更新）

1. **本地多玩家互動**：使用藍牙或 Wi-Fi 支持本地的多人互動遊戲體驗。
2. **更多角色**：支持更多角色及其技能，進一步增強遊戲深度。

授權條款

本專案依照 Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0) 授權條款發佈。這意味著你可以自由地分享和修改本專案，前提是必須署名歸屬原作者，且不可將本專案用於商業用途。

請參閱隨附的 LICENSE 文件以獲取更多詳情。
