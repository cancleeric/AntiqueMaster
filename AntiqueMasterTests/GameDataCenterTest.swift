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


    func tearDown() async {
        await GameDataCenter.shared.reset()
    }
}
