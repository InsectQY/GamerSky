//
//  WebViewImage.swift
//  GamerSky
//
//  Created by QY on 2018/5/4.
//  Copyright © 2018年 QY. All rights reserved.
//

import Foundation

struct WebViewImage: Codable {
    
    /// 图片标题
    let caption: String
    /// 高清图片
    let hdImageURL: String
    /// 普通图片
    let imageURL: String
}
