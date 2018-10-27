//
//  AppDelegate+Root.swift
//  SSDispatch
//
//  Created by insect_qy on 2018/9/13.
//  Copyright © 2018年 insect_qy. All rights reserved.
//

import Foundation
import URLNavigator

extension AppDelegate {
    
    // MARK: - 设置根控制器
    func initRootViewController() {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = TabBarController()
        window?.makeKeyAndVisible()
    }
    
    // MARK: - 初始化路由
    func initRouter() {
        NavigationMap.initialize()
    }
    
    // MARK: - 加载用户本地主题
    func loadTheme() {
        
        guard let preference = QYUserDefaults.getUserPreference() else {return}
        AppTheme.switchTo(preference.currentTheme)
    }
}
