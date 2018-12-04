//
//  QYUserDefaults.swift
//  GamerSky
//
//  Created by QY on 2018/4/4.
//  Copyright © 2018年 QY. All rights reserved.
//

import Foundation
import DefaultsKit

struct QYUserDefaults {

    // MARK: - 从本地获取偏好设置(key是用户id, 为本地多用户切换做预留, 不传为游客模式)
    static func getUserPreference(key: String = "Guest") -> Preference? {
        return Defaults().get(for: Key<Preference>(key + "Preference"))
    }
    
    // MARK: - 保存用户偏好设置(key是用户id, 为本地多用户切换做预留, 不传为游客模式)
    static func saveUserPreference(key: String = "Guest", preference: Preference) {
        Defaults().set(preference, for: Key<Preference>(key + "Preference"))
    }
}
