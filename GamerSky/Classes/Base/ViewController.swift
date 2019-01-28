//
//  BaseViewController.swift
//  GamerSky
//
//  Created by QY on 2018/4/2.
//  Copyright © 2018年 QY. All rights reserved.
//

import UIKit
import SwiftTheme

class ViewController: UIViewController {

    /// 默认背景颜色
    private var defaultBackgroundColor = "colors.backgroundColor"
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        initTheme()
        registerNotification()
        makeUI()
        bindViewModel()
    }
    
    // MARK: - deinit
    deinit {
        print("\(type(of: self)): Deinited")
    }
    
    // MARK: - didReceiveMemoryWarning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("\(type(of: self)): Received Memory Warning")
    }
    
    func makeUI() {
        view.backgroundColor = .white
    }
    
    func bindViewModel() {
        
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
extension ViewController {
    
    // MARK: - 注册通知
    private func registerNotification() {
    
    }
    
    // MARK: - tabBar重复点击
    func tabBarRepeatClick() {
        
        guard view.isShowingOnKeyWindow() else {return}
        repeatClickTabBar()
    }
}
