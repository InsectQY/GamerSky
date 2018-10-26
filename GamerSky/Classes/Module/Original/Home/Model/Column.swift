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
    let Id: Int
    /// 标题
    let title: String
    /// 图片
    var icon: String?
    /// 描述
    let description: String
}

extension ColumnList: ConvertToStringable {
    
    typealias Result = ColumnList
    var valueString: String { return toString(result: self) }
}

struct ColumnContent: Codable {
    
    /// 专栏名称
    let title: String?
    /// 专栏 icon
    let icon: String?
    /// 专栏描述
    let description: String?
    /// 专栏内容
    let childElements: [ColumnElement]
}

struct ColumnElement: Codable {
    
    /// ID
    let Id: Int
    /// 标题
    let title: String?
    /// 图片
    let thumbnailURL: String?
    /// 专栏名称
    let zhuanlanTitle: String?
    /// 作者名
    let authorName: String?
    /// 作者头像
    let authorPhoto: String?
    /// 评论数
    let commentsCount: Int
    /// 收藏数
    let likeCount: Int
    /// 更新时间
    let updateTime: Int
    /// 更新时间
    var updateTimeString: String {
        get {
            return updateTime.compare()
        }
    }
}
