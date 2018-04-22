//
//  GameComment.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/22.
//Copyright © 2018年 engic. All rights reserved.
//

import Foundation

struct GameComment: Codable {

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
    var platform: String
    /// 评分
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
    /// 是否包含活动
    var Position: String
    /// 评分
    var gsScore: String
    /// 游戏标签
    var gameTag: [String]
    /// 子评论
    var reviews: [GameReviews]?
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
