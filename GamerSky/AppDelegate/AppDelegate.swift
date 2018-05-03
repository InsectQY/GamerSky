//
//  AppDelegate.swift
//  GamerSky
//
//  Created by engic on 2018/4/2.
//  Copyright © 2018年 engic. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static let tabBarContoller = TabBarController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        initRootViewController()
        fitiOSEleven()
        loadTheme()
        initBugly()
        return true
    }
}

// MARK: - SDK 设置
extension AppDelegate {
    
    // MARK: - 初始化崩溃统计
    private func initBugly() {
        
        let config = BuglyConfig()
        config.blockMonitorEnable = true
        Bugly.start(withAppId: BuglyID, config: config)
    }
}

// MARK: - 基础设置
extension AppDelegate {
    
    // MARK: - 设置根控制器
    private func initRootViewController() {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = AppDelegate.tabBarContoller
        window?.makeKeyAndVisible()
    }
    
    // MARK: - contentInsetAdjustmentBehavior
    private func fitiOSEleven() {
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        }
    }
    
    // MARK: - 加载用户本地主题
    private func loadTheme() {
        
        guard let preference = QYUserDefaults.getUserPreference() else {return}
        AppTheme.switchTo(preference.currentTheme)
    }
}
