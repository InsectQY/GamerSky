//
//  GameDetail.swift
//  GamerSky
//
//  Created by insect_qy on 2018/7/13.
//  Copyright © 2018年 engic. All rights reserved.
//

import Foundation

struct GameDetail: Codable {
    
    /// 背景图片
    var backgroundURL: String
    /// 是否有中文
    var chinese: Int
    /// 游戏介绍
    var description: String
    /// 开发者
    var developer: String
    /// 游戏时长
    var gameLength: String
    /// 游戏标签
    var gameTag: [GameTag]
    /// 游戏类型
    var gameType: String
    /// GS评分
    var gsScore: Float
    /// 是否发售
    var market: Bool
    /// 我的评分
    var myScore : Float
    /// 游戏登陆的平台
    var platform: String
    /// 玩过的人数
    var playedCount: Int
    /// 制作厂商
    var producer: String
    /// 打分的人数
    var scoreUserCount: Int
    /// 发售时间
    var sellTime: String
    /// 小图
    var thumbnailURL: String
    /// 中文游戏名
    var title : String
    /// 英文游戏名
    var englishTitle: String
    /// 用户打分
    var userScore: Float
    /// 想玩的人数
    var wantplayCount: Int
}
