# AntiqueMaster 開發步驟

## 開發步驟

1. 完善遊戲核心邏輯

    • 角色分配：實現遊戲中角色隨機分配的邏輯（鑑定者、偽造者等）。目前角色和玩家的分配應該透過程序自動完成。
    • 回合管理：確保每個玩家依次進行操作，並記錄每一輪的進度。你可能需要設計一個系統來跟蹤輪到哪個玩家進行操作。
    • 投票系統：實現玩家對銅像的投票功能，並在每輪結束時揭示真偽和投票結果。

2. 圖形與用戶介面優化

    • UI 改進：改善或設計更符合遊戲氛圍的 UI 元素。當前的圖像佈局可以優化，加入更多遊戲主題相關的圖形設計。
    • 動畫效果：當玩家進行操作時，加入動畫效果來提升互動性。SpriteKit 可以用於製作角色的移動、鑑定或投票過程中的動畫。

3. 遊戲數據持久化

    • 遊戲進度保存：如果玩家中途退出，可以考慮實現遊戲進度的保存功能。這樣可以在玩家返回時繼續進行遊戲。
    • 玩家數據跟蹤：考慮將遊戲中的分數、投票歷史等數據保存起來，並在遊戲結束後提供詳細的數據回顧。

4. 多玩家支持

    • 如果你的應用計劃支持多玩家模式，你可以開始實現玩家之間的互動（例如使用藍牙或局域網）。這樣可以讓多個玩家透過手機進行同場遊戲。

5. 音效與背景音樂

    • 加入適當的音效和背景音樂來提升遊戲氛圍，例如在玩家完成鑑定或投票後加入聲效反饋，或者在遊戲背景中播放與主題相配的音樂。

6. 規則和遊戲流程的細化

    • 確保你完整地實現了遊戲的所有規則，並且應用能夠引導玩家依據遊戲規則進行操作。
    • 根據遊戲的版本更新和規則調整，隨時更新應用中的規則描述和處理方式。

7. 測試與調整

    • 在進一步添加新功能之前，進行功能測試，特別是對已實現功能（如角色分配、投票、分數計算等）的邏輯和界面進行調整。
    • 聯合測試功能，包括遊戲邏輯、畫面顯示與排版、聲音、網絡聯機等多方面。

8. 考慮上架與發佈

    • 準備完成的時候，根據 App Store 的要求優化應用程式的元數據（如應用描述、截圖等）。
    • 準備好相關的隱私政策，尤其是如果應用會收集用戶數據。

## 使用技術

- SpriteKit：處理遊戲畫面呈現、動畫效果以及玩家互動。
- Swift：負責遊戲邏輯和應用開發，提供高效的遊戲管理和 UI 處理。
- Bluetooth/Wi-Fi（計劃中）：支援本地多玩家連線，讓多個玩家可以共同遊玩。

## 計劃功能（未來更新）

1. **本地多玩家互動**：使用藍牙或 Wi-Fi 支持本地的多人互動遊戲體驗。
2. **更多角色**：支持更多角色及其技能，進一步增強遊戲深度。
