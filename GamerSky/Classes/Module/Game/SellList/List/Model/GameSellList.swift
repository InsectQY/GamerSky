//
//  GameSellList.swift
//  GamerSky
//
//  Created by Insect on 2018/4/17.
//  Copyright © 2018年 QY. All rights reserved.
//

import Foundation

struct GameSellList: Codable {
    
    /// 详情ID
    var contentId : Int
    /// 图片
    var thumbnailURL: String
    /// 游戏名称
    var title: String
    /// 发售时间
    var sellTime: String
    /// 发售平台
    var platform: String
    /// 游戏类型
    var gameType: String
    /// 开发者
    var developer: String
    /// 制作者
    var producer: String
    /// 英文游戏名
    var englishTitle: String
    /// 是否包含活动
    var position: String?
    /// 评分
    var gsScore: Float
    /// 期待人数
    var wantPlayCount: Int
}
