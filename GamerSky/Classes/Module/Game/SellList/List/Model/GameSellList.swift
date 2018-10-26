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
    let contentId : Int
    /// 图片
    let thumbnailURL: String
    /// 游戏名称
    let title: String
    /// 发售时间
    let sellTime: String
    /// 发售平台
    let platform: String
    /// 游戏类型
    let gameType: String
    /// 开发者
    let developer: String
    /// 制作者
    let producer: String
    /// 英文游戏名
    let englishTitle: String
    /// 是否包含活动
    let position: String?
    /// 评分
    let gsScore: Float
    /// 期待人数
    let wantPlayCount: Int
}
