//
//  GameComment.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/22.
//Copyright © 2018年 QY. All rights reserved.
//

import Foundation

struct GameComment: Codable {

    /// 是否玩过 (想玩还是玩过)
    let likeType: PlayType
    /// 评论的 ID
    let reviewid: Int
    /// 评论内容
    let content: String
    /// 用户头像
    let img_URL: String
    /// userid
    let user_id: String
    /// 用户名
    let nickname: String
    /// 平台
    let platform: String?
    /// 玩家评分
    let rating: Int
    /// 点赞数
    let like: Int
    /// 评论数
    let reviewCount: Int
    /// ID
    let Id: Int
    /// 游戏图片
    let DefaultPicUrl: String
    /// 时间
    let create_time: Int
    /// 游戏类型
    let GameType: String
    /// 游戏名称
    let Title: String
    /// 是否包含活动
    let Position: String
    /// GS评分
    let gsScore: String
    /// 游戏标签
    let gameTag: [String]
    /// 子评论
    let reviews: [GameReviews]?
    /// 游戏类型
    var gameTagString: String? {
        return gameTag.joined(separator: " ")
    }
    /// GS评分
    var gsRating: Double {
        
        get {
            let score = Double(self.gsScore) ?? 0
            return score * 0.5
        }
    }
    /// 玩家评分
    var commentRating: Double {
        get {
            return Double(rating) * 0.5
        }
    }
}

struct GameReviews: Codable {
    
    /// 评论的 ID
    let reviewid: Int
    /// 时间
    let create_time: Int
    /// 评论内容
    let content: String
    /// userid
    let user_id: String
    /// 用户头像
    let img_URL: String
    /// 用户名
    let nickname: String
    /// 回复的人用户名
    let replynickname: String
}
