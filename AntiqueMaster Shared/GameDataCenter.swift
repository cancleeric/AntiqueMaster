//
//  GameDataCenter.swift
//  AntiqueMaster Shared
//
//  Created by EricWang on 2024/10/29.
//  - 新增 `GameDataCenter` 類別來管理遊戲數據，例如玩家信息。

import Foundation

class GameDataCenter {
    static let shared = GameDataCenter()

    init() {}

    private var _players = SafeStorageQueue<Player>(
        label: "com.antiquemaster.gamedatacenter.players")
    var players: [Player] {
        return _players.getAll()
    }

    func initializePlayers(names: [String]) {
        reset()
        _players.add(contentsOf: names.map { Player(name: $0) })
    }

    func reset() {
        _players.clear()  // 清空 _players
    }
}
