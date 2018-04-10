//
//  Game.swift
//  GamerSky
//
//  Created by Insect on 2018/4/9.
//  Copyright © 2018年 engic. All rights reserved.
//

import Foundation

struct GameSpecialList: Codable {

    var nodeId: Int
    var title: String
    var image: String
    var smallImage: String
    var des: String
}

struct GameInfo: Codable {
    
    /// ID
    var Id: Int
    /// 标题
    var Title: String
    /// 默认图
    var DefaultPicUrl: String
    /// 所属分类
    var subgroup: String?
    /// 是否包含活动(包含则显示活动图片)
    var Position: String?
    /// 得分
    var gsScore: String?
    /// 大图
    var largeImage: String?
    /// 描述
    var description: String?
    /// 想玩的人数
    var wantplayCount: Int?
    /// 发售时间
    var allTimeT: String?
    /// 评分
    lazy var score: Double = {
        
        let score = Double(gsScore ?? "") ?? 0
        return score * 0.5
    }()
}

struct GameTag: Codable {
    
    var searchid: Int
    var name: String
}
