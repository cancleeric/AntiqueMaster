//
//  GameRole.swift
//  AntiqueMaster
//
//  Created by EricWang on 2024/10/30.
//  Modify: 2024/10/30
//  - Expanded the number of players to 8.
//
enum GameRole: String {
    case appraiser  // 鑑定者
    case forger  // 偽造者
}

struct Player {
    let name: String
    var role: GameRole?
}

var players: [Player] = [
    Player(name: "玩家1", role: nil),
    Player(name: "玩家2", role: nil),
    Player(name: "玩家3", role: nil),
    Player(name: "玩家4", role: nil),
    Player(name: "玩家5", role: nil),
    Player(name: "玩家6", role: nil),
    Player(name: "玩家7", role: nil),
    Player(name: "玩家8", role: nil),
]
