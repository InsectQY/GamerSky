//
//  NodeList.swift
//  GamerSky
//
//  Created by Insect on 2018/4/3.
//  Copyright © 2018年 QY. All rights reserved.
//

import Foundation

struct ColumnList: Codable {
    
    /// ID
    var Id: Int
    /// 标题
    var title: String
    /// 图片
    var icon: String?
    /// 描述
    var description: String
}

struct ColumnContent: Codable {
    
    /// 专栏名称
    var title: String?
    /// 专栏 icon
    var icon: String?
    /// 专栏描述
    var description: String?
    /// 专栏内容
    var childElements: [ColumnElement]
}

struct ColumnElement: Codable {
    
    /// ID
    var Id: Int
    /// 标题
    var title: String?
    /// 图片
    var thumbnailURL: String?
    /// 专栏名称
    var zhuanlanTitle: String?
    /// 作者名
    var authorName: String?
    /// 作者头像
    var authorPhoto: String?
    /// 评论数
    var commentsCount: Int
    /// 收藏数
    var likeCount: Int
    /// 更新时间
    var updateTime: Int
    /// 更新时间
    var updateTimeString: String {
        get {
            return updateTime.compare()
        }
    }
}
