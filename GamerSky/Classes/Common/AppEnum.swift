//
//  AppEnum.swift
//  GamerSky
//
//  Created by QY on 2018/4/4.
//  Copyright © 2018年 QY. All rights reserved.
//

import UIKit

/// 游戏类型
///
/// - expected: 最期待的游戏
/// - hot: 大家都在玩的游戏
/// - waitSell: 即将上市的游戏
enum GameType: String {

    case expected = "most-expected"
    case hot = "recent-hot"
    case waitSell = "new-selling"
}

/// 搜索类型
///
/// - global: 综合
/// - strategy: 攻略
/// - game: 游戏
/// - news: 新闻
enum SearchType: String {
    
    case global = "global"
    case strategy = "strategy"
    case game = "game"
    case news = "news"
}

/// 第三方登陆种类
///
/// - QQ: QQ
/// - WeChat: 微信
/// - WeiBo: 微博
enum ThirdPartyLogin: String {
    
    case QQ = "qq"
    case WeChat = "weixin"
    case WeiBo = "weibo"
}

/// 游戏发售表排行方式
///
/// - popular: 按人气
/// - date: 按时间
enum GameSellSort: String {
    
    case popular = "popularity"
    case date = "date"
}

/// 游戏排行榜筛选方式
///
/// - hot: 热门榜
/// - fractions: 高分榜
enum GameRankingType: String {
    
    case hot = "hot"
    case fractions = "fractions"
}

/// 游戏评论类型
///
/// - hot: 热门
/// - latest: 最新
enum GameCommentType: String {
    
    case hot = "hot"
    case latest = "latest"
}

/// 对某款游戏的喜欢程度
///
/// - wantPlay: 想玩
/// - played: 玩过
enum PlayType: String, Codable {
    
    case wantPlay = "WantPlay"
    case played = "Played"
}


/// 新闻详情页面字体大小
///
/// - small: 小
/// - medium: 中
/// - big: 大
enum FontSizeType: Int, Codable {
    
    case small = 0
    case medium = 1
    case big = 2
}
