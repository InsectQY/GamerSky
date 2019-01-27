//
//  BaseViewController.swift
//  GamerSky
//
//  Created by QY on 2018/4/2.
//  Copyright © 2018年 QY. All rights reserved.
//

import UIKit
import SwiftNotificationCenter
import SwiftTheme

class ViewController: UIViewController {

    /// 默认背景颜色
    private var defaultBackgroundColor = "colors.backgroundColor"
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        initTheme()
        registerNotification()
    }
    
    // MARK: - deinit
    deinit {
        print("\(self)---销毁")
    }
    
    /// 重复点击 TabBar
    func repeatClickTabBar() {}
}

extension ViewController {
    
    /// 主题背景颜色(传路径)
    @IBInspectable var qy_themeBackgroundColor: String? {
        
        set {
            
            guard let newValue = newValue else {return}
            defaultBackgroundColor = newValue
            initTheme()
        }
        
        get {
            return defaultBackgroundColor
        }
    }
}

extension ViewController {
    
    // MARK: - 主题设置
    private func initTheme() {
        
        view.theme_backgroundColor = ThemeColorPicker(keyPath: defaultBackgroundColor)
    }
}

// MARK: - 通知
extension ViewController: TabBarProtocol {
    
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
