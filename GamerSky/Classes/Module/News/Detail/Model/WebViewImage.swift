//
//  WebViewImage.swift
//  GamerSky
//
//  Created by engic on 2018/5/4.
//  Copyright © 2018年 engic. All rights reserved.
//

import Foundation

struct WebViewImage: Codable {
    
    /// 图片标题
    var caption: String
    /// 高清图片
    var hdImageURL: String
    /// 普通图片
    var imageURL: String
}
