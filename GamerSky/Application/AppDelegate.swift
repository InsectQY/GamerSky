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
        
        setUpRootViewController()
        fitiOSEleven()
        return true
    }
}

// MARK: - 基础设置
extension AppDelegate {
    
    // MARK: - 设置根控制器
    private func setUpRootViewController() {
        
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
}
