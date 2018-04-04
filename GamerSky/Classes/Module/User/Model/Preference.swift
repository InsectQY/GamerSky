//
//  Preference.swift
//  GamerSky
//
//  Created by engic on 2018/4/4.
//  Copyright © 2018年 engic. All rights reserved.
//

import Foundation

struct Preference: Codable {
    
    /// 当前选择的主题
    var currentTheme: AppTheme
    /// 是否需要无图
    var isNoneImage: Bool
}
