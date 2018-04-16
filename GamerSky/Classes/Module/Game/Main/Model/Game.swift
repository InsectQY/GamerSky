//
//  Game.swift
//  GamerSky
//
//  Created by Insect on 2018/4/9.
//  Copyright © 2018年 engic. All rights reserved.
//

import Foundation

struct GameSpecialList: Codable {

    /// ID
    var nodeId: Int
    /// 标题
    var title: String
    /// 大图
    var image: String
    /// 小图
    var smallImage: String
    /// 描述
    var des: String
    /// 是否含有子标题(如果有就显示多组的 tableview 没有就显示带排行的 tableview)
    var hasSubList: Bool
}

struct GameSpecialSubList: Codable {
    
    /// 标题
    var title: String
    /// 数量
    var count: Int?
}

struct GameSpecialDetail: Codable {
    
    /// ID
    var Id: Int
    /// 所属分类
    var subgroup: String?
    /// 游戏名称
    var Title: String
    /// 图片
    var DefaultPicUrl: String
    /// 游戏类型
    var GameType: String
    /// 评分
    var gsScore: String
    /// 描述
    var description: String?
    /// 大图
    var largeImage: String?
    /// 游戏标签
    var gameTag: [String]
    /// 是否包含活动(包含则显示活动图片)
    var Position: String
    
    var gameTagTitle: String? {
        return gameTag.joined(separator: " ")
    }
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
    /// 发售时间(时间格式: 2018/4/25 0:00:00)
    var AllTimeT: String?
    /// 发售月份    
    var month: String? {
        
        get {
            
            let date = AllTimeT?.components(separatedBy: "/")
            return date != nil ? date![1] : "未知"
        }
    }
    /// 评分
    lazy var score: Double = {
        
        let score = Double(gsScore ?? "") ?? 0
        return score * 0.5
    }()
}

struct GameTag: Codable {
    
    /// ID
    var searchid: Int
    /// 标签名称
    var name: String
}
