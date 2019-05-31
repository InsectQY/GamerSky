//
//  AppConfig.swift
//  GamerSky
//
//  Created by QY on 2018/4/2.
//  Copyright © 2018年 QY. All rights reserved.
//

import UIKit

struct Configs {

    struct Network {

        static let appHostUrl = "http://appapi2.gamersky.com"
        static let iUrl = "http://i.gamersky.com"
        static let yangGuangUrl = "http://365yg.com"
        static let weChatUrl = "https://api.weixin.qq.com"
    }

    struct Dimensions {

        static let screenWidth: CGFloat = UIScreen.main.bounds.size.width
        static let screenHeight: CGFloat = UIScreen.main.bounds.size.height
        static let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        static let naviBarHeight: CGFloat = 44
        static let topHeight: CGFloat = statusBarHeight + naviBarHeight
    }

    struct Time {
        static let imageTransition: TimeInterval = 1.0
        /// 图片缓存时间 (1 周)
        static let maxImageCache: TimeInterval = 60 * 60 * 24 * 7
        /// 图片加载超时时间
        static let imageDownloadTimeout: TimeInterval = 15
        /// 网络请求超时时间
        static let netWorkTimeout: TimeInterval = 15
    }
}
