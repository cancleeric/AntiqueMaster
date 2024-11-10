//
//  GameDataCenterTest.swift
//  AntiqueMasterTests
//
//  Created by EricWang on 2024/11/10.
//

import Testing

struct GameDataCenterTest {

    @Test
    func testInitializePlayers() async throws {
        // Given
        let gameDataCenter = GameDataCenter.shared
        await gameDataCenter.reset()  // 確保重置狀態
        let playerNames = ["Alice", "Bob", "Charlie"]

        // When
        gameDataCenter.initializePlayers(names: playerNames)

        // Then
        #expect(gameDataCenter.players.count == playerNames.count, "玩家數量應與輸入的名稱數量一致")
        #expect(gameDataCenter.players.map { $0.name } == playerNames, "玩家名稱應與初始化名稱匹配")
    }

    @Test
      func testInitializeGameDataCenter() async {
          // Given
          let gameDataCenter = GameDataCenter.shared
          await gameDataCenter.reset()  // 確保重置狀態

          // When
          gameDataCenter.initializePlayers(names: ["Player1", "Player2", "Player3", "Player4", "Player5", "Player6", "Player7", "Player8"])

          // Then
          #expect(gameDataCenter.players.count == 8, "初始化後玩家數量應為 8")
          #expect(gameDataCenter.players.first?.name == "Player1", "第一個玩家名稱應為 'Player1'")
          #expect(gameDataCenter.players.last?.name == "Player8", "最後一個玩家名稱應為 'Player8'")
      }

    func tearDown() async {
        await GameDataCenter.shared.reset()
    }
}
