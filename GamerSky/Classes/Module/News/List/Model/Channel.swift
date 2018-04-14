//
//  channel.swift
//  GamerSky
//
//  Created by engic on 2018/4/2.
//  Copyright © 2018年 engic. All rights reserved.
//

import Foundation

struct Channel: Codable {
    
    /// 频道 ID
    var nodeId: Int
    /// 频道名称
    var nodeName: String
    var isTop: Bool
}

struct ChannelList: Codable {
    
    /// 标题
    var title: String
    /// 阅读量
    var readingCount: Int
    /// 详情需要用它拼接
    var contentId: Int
    /// 更新时间
    var updateTime: Int
    /// 评论数
    var commentsCount: Int
    /// 图片
    var thumbnailURLs: [String]?
    /// 轮播图
    var childElements: [ChannelList]?
}
