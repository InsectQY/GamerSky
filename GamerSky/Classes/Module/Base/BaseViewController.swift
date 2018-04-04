//
//  BaseViewController.swift
//  GamerSky
//
//  Created by engic on 2018/4/2.
//  Copyright © 2018年 engic. All rights reserved.
//

import UIKit
import SwiftNotificationCenter
import SwiftTheme

class BaseViewController: UIViewController {

    /// 主题背景颜色(传路径)
    public var qy_themeBackgroundColor = "colors.backgroundColor" {
        
        didSet {
            initTheme()
        }
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        initTheme()
        registerNotification()
    }
    
    deinit {
        print("\(self)---销毁")
    }
    
    func repeatClickTabBar() {}
}

extension BaseViewController {
    
    // MARK: - 主题设置
    private func initTheme() {
        view.theme_backgroundColor = ThemeColorPicker(keyPath: qy_themeBackgroundColor)
    }
}

// MARK: - 通知
extension BaseViewController: TabBarProtocol {
    
    // MARK: - 注册通知
    private func registerNotification() {
        Broadcaster.register(TabBarProtocol.self, observer: self)
    }
    
    // MARK: - tabBar重复点击
    func tabBarRepeatClick() {
        
        guard view.isShowingOnKeyWindow() else {return}
        repeatClickTabBar()
    }
}
