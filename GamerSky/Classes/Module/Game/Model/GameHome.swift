//
//  GameHomeHeader.swift
//  GamerSky
//
//  Created by Insect on 2018/4/9.
//  Copyright © 2018年 engic. All rights reserved.
//

import Foundation

enum GameHome: String, Codable {
    
    case recommend = "新游推荐"
    case hot = "最近大家都在玩"
    case column = "特色专题"
    case expected = "最期待游戏"
    case newSelling = "即将上市"
    case gameTag = "找游戏"
}

struct GameHomeSection: Codable {
    
    var leftTitle: String
    var rightTitle: String
    var sectionType: GameHome?
}

struct GameHomeHeader: Codable {

    var title: String
    var image: String
}
