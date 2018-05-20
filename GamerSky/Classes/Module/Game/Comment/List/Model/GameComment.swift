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
    var likeType: PlayType
    /// 评论的 ID
    var reviewid: Int
    /// 评论内容
    var content: String
    /// 用户头像
    var img_URL: String
    /// userid
    var user_id: String
    /// 用户名
    var nickname: String
    /// 平台
    var platform: String?
    /// 玩家评分
    var rating: Int
    /// 点赞数
    var like: Int
    /// 评论数
    var reviewCount: Int
    /// ID
    var Id: Int
    /// 游戏图片
    var DefaultPicUrl: String
    /// 时间
    var create_time: Int
    /// 游戏类型
    var GameType: String
    /// 游戏名称
    var Title: String
    /// 是否包含活动
    var Position: String
    /// 游民评分
    var gsScore: String
    /// 游戏标签
    var gameTag: [String]
    /// 子评论
    var reviews: [GameReviews]?
    /// 游戏类型
    var gameTagString: String? {
        return gameTag.joined(separator: " ")
    }
    /// 游民评分
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
    var reviewid: Int
    /// 时间
    var create_time: Int
    /// 评论内容
    var content: String
    /// userid
    var user_id: String
    /// 用户头像
    var img_URL: String
    /// 用户名
    var nickname: String
    /// 回复的人用户名
    var replynickname: String
}
