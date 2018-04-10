//
//  GameHomeHeader.swift
//  GamerSky
//
//  Created by Insect on 2018/4/9.
//  Copyright © 2018年 engic. All rights reserved.
//

import Foundation

enum GameHomeSectionType: Int, Codable {
    
    /// 新游推荐
    case recommend = 0
    /// 最近大家都在玩
    case hot = 1
    /// 特色专题
    case column = 2
    /// 即将上市
    case waitSelling = 3
    /// 排行榜
    case ranking = 4
    /// 最期待游戏
    case expected = 5
    /// 找游戏
    case gameTag = 6
}

struct GameHomeSection: Codable {
    
    /// 左边标题
    var leftTitle: String
    /// 右边标题
    var rightTitle: String
    var sectionType: GameHomeSectionType
}

struct GameHomeHeader: Codable {

    /// 文字
    var title: String
    /// 图片
    var image: String
}
