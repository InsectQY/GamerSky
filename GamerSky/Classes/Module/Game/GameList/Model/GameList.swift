//
//  GameList.swift
//  GamerSky
//
//  Created by Insect on 2018/4/23.
//  Copyright © 2018年 engic. All rights reserved.
//

import Foundation

struct GameList: Codable {
    
    /// 游戏总数
    var gamesCount: Int
    /// 游戏信息
    var childelements: [GameChildElement]
}

struct GameChildElement: Codable {
    
    /// 游戏ID
    var Id: Int
    /// 游戏名称
    var title: String
    /// 游戏评分
    var userScore: Float?
    /// 游戏图片
    var image: String
    /// 是否显示活动图片
    var position: String?
}
