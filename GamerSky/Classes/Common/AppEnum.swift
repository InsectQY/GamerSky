//
//  AppEnum.swift
//  GamerSky
//
//  Created by engic on 2018/4/4.
//  Copyright © 2018年 engic. All rights reserved.
//

import UIKit

public let ScreenWidth: CGFloat = UIScreen.main.bounds.size.width
public let ScreenHeight: CGFloat = UIScreen.main.bounds.size.height

enum Device {
    
    case iPhone4
    case iPhone5
    case iPhone6
    case iPhone6p
    case iPhoneX
    
    // MARK: - 判断屏幕尺寸
    static func Size() -> Device {
        
        switch (ScreenWidth, ScreenHeight) {
        case (320, 480), (480, 320):
            return .iPhone4
        case (320, 568), (568, 320):
            return .iPhone5
        case (375, 667), (667, 375):
            return .iPhone6
        case (414, 736), (736, 414):
            return .iPhone6p
        case (375, 812), (812, 375):
            return .iPhoneX
        default:
            return .iPhone6
        }
    }
}

enum GameType: String {
    /// 最期待的游戏
    case expected = "most-expected"
    /// 大家都在玩的游戏
    case hot = "recent-hot"
    /// 即将上市的游戏
    case waitSell = "new-selling"
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

enum ThirdPartyLogin: String {
    
    /// QQ
    case QQ = "qq"
    /// 微信
    case WeChat = "weixin"
    /// 微博
    case WeiBo = "weibo"
}

enum GameSellSort: String {
    
    /// 按人气
    case popular = "popularity"
    /// 按时间
    case date = "date"
}

enum GameRankingType: String {
    /// 热门榜
    case hot = "hot"
    /// 高分榜
    case fractions = "fractions"
}
