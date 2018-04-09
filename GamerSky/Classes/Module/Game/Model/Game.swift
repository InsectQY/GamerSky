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

struct GameSpecialDetail: Codable {
    
    /// ID
    var Id: Int
    /// 所属分类
    var subgroup: String
    /// 标题
    var Title: String
    /// 默认图
    var DefaultPicUrl: String
    /// 是否包含活动(包含则显示活动图片)
    var Position: String?
    /// 得分
    var gsScore: String?
    /// 大图
    var largeImage: String
    /// 描述
    var description: String
    /// 评分
    lazy var score: Double = {
        
        let score = Double(gsScore ?? "") ?? 0
        return score * 0.5
    }()
}
