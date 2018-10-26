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
    let backgroundURL: String
    /// 是否有中文
    let chinese: Int
    /// 游戏介绍
    let description: String
    /// 开发者
    let developer: String
    /// 游戏时长
    let gameLength: String
    /// 游戏标签
    let gameTag: [GameTag]
    /// 游戏类型
    let gameType: String
    /// GS评分
    let gsScore: Float
    /// 是否发售
    let market: Bool
    /// 我的评分
    let myScore : Float
    /// 游戏登陆的平台
    let platform: String
    /// 玩过的人数
    let playedCount: Int
    /// 制作厂商
    let producer: String
    /// 打分的人数
    let scoreUserCount: Int
    /// 发售时间
    let sellTime: String
    /// 小图
    let thumbnailURL: String
    /// 中文游戏名
    let title : String
    /// 英文游戏名
    let englishTitle: String
    /// 用户打分
    let userScore: Float
    /// 想玩的人数
    let wantplayCount: Int
}
