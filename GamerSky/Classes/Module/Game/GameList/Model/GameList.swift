//
//  GameList.swift
//  GamerSky
//
//  Created by Insect on 2018/4/23.
//  Copyright © 2018年 QY. All rights reserved.
//

import Foundation

struct GameList: Codable {
    
    /// 游戏总数
    let gamesCount: Int
    /// 游戏信息
    let childelements: [GameChildElement]
}

struct GameChildElement: Codable {
    
    /// 游戏ID
    let Id: Int
    /// 游戏名称
    let title: String
    /// 游戏评分
    let userScore: Float?
    /// 游戏图片
    let image: String
    /// 是否显示活动图片
    let position: String?
}
