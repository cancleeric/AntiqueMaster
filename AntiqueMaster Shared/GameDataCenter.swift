//
//  GameDataCenter.swift
//  AntiqueMaster Shared
//
//  Created by EricWang on 2024/10/29.
//  - 新增 `GameDataCenter` 類別來管理遊戲數據，例如玩家信息。

import Foundation

/// 遊戲數據中心，負責管理遊戲中的所有數據
class GameDataCenter {
    static let shared = GameDataCenter()

    private init() {}

    var players: [Player] = []

    /// 初始化玩家資料
    func initializePlayers(names: [String]) {
        players = names.map { Player(name: $0) }
    }
}
