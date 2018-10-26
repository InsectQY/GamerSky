//
//  Game.swift
//  GamerSky
//
//  Created by Insect on 2018/4/9.
//  Copyright © 2018年 QY. All rights reserved.
//

import Foundation

struct GameSpecialList: Codable {

    /// ID
    let nodeId: Int
    /// 标题
    let title: String
    /// 大图
    let image: String
    /// 小图
    let smallImage: String
    /// 描述
    let des: String
    /// 是否含有子标题(如果有就显示多组的 tableview 没有就显示带排行的 tableview)
    let hasSubList: Bool
}

struct GameSpecialSubList: Codable {
    
    /// 标题
    let title: String
    /// 数量
    let count: Int?
}

struct GameSpecialDetail: Codable {
    
    /// ID
    let Id: Int
    /// 所属分类
    let subgroup: String?
    /// 游戏名称
    let Title: String
    /// 图片
    let DefaultPicUrl: String
    /// 游戏类型
    let GameType: String
    /// 评分
    let gsScore: String
    /// 描述
    let description: String?
    /// 大图
    let largeImage: String?
    /// 游戏标签
    let gameTag: [String]
    /// 是否包含活动(包含则显示活动图片)
    let Position: String
    
    /// 评分
    var score: Double {
        
        get {
            let score = Double(self.gsScore) ?? 0
            return score * 0.5
        }
    }
    
    var gameTagString: String? {
        return gameTag.joined(separator: " ")
    }
}

struct GameInfo: Codable {
    
    /// ID
    let Id: Int
    /// 标题
    let Title: String
    /// 默认图
    let DefaultPicUrl: String
    /// 所属分类
    let subgroup: String?
    /// 是否包含活动(包含则显示活动图片)
    let Position: String?
    /// 得分
    let gsScore: String?
    /// 大图
    let largeImage: String?
    /// 描述
    let description: String?
    /// 想玩的人数
    let wantplayCount: Int?
    /// 发售时间(时间格式: 2018/4/25 0:00:00)
    let AllTimeT: String?
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
    let searchid: Int
    /// 标签名称
    let name: String
}
