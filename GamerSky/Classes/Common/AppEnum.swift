//
//  AppEnum.swift
//  GamerSky
//
//  Created by engic on 2018/4/4.
//  Copyright © 2018年 engic. All rights reserved.
//

import Foundation

enum GameType: String {
    /// 最期待的游戏
    case expected = "most-expected"
    /// 大家都在玩的游戏
    case hot = "recent-hot"
    /// 即将上市的游戏
    case newSelling = "new-selling"
}

enum GameRanking: String {
    /// 热门榜
    case hot = "hot"
    /// 高分榜
    case score = "fractions"
}

enum SearchType: String {
    
    /// 综合
    case global = "global"
    /// 攻略
    case strategy = "strategy"
    /// 游戏
    case game = "game"
    /// 新闻
    case news = "news"
}
