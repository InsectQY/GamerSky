//
//  AppTheme.swift
//  GamerSky
//
//  Created by engic on 2018/4/3.
//  Copyright © 2018年 engic. All rights reserved.
//

import Foundation
import SwiftTheme

enum AppTheme: Int {
    
    case day = 0
    case night = 1
    
    static var before = AppTheme.day
    static var current = AppTheme.day
    
    /// 选择主题
    static func switchTo(_ theme: AppTheme) {
        
        before = current
        current = theme
        
        switch theme {
        case .day: ThemeManager.setTheme(plistName: "default_theme", path: .mainBundle)
        case .night: ThemeManager.setTheme(plistName: "night_theme", path: .mainBundle)
        }
    }
    /// 选择了夜间主题
    static func switchNight(_ isToNight: Bool) {
        switchTo(isToNight ? .night : .day)
    }
    /// 判断当前是否是夜间主题
    static func isNight() -> Bool {
        return current == .night
    }
}
