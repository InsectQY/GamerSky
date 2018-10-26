//
//  NavigationController.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/5/23.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit
import FDFullscreenPopGesture
import SwiftTheme

class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fd_fullscreenPopGestureRecognizer.isEnabled = true
        
        // 导航栏背景和文字设置
        let naviBar: UINavigationBar = UINavigationBar.appearance()
        naviBar.theme_barTintColor = "colors.navigationBarTintColor"
        naviBar.backgroundColor = .white
        
        view.backgroundColor = .white
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if children.count >= 1 {
            
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "common_Icon_Back_20x20_Black"), style: .plain, target: self, action: #selector(backBtnDidClick))
            // 隐藏要push的控制器的tabbar
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    // MARK: - 全屏滑动返回(不想用第三方的话可以使用这个方法)
    private func fullscreenPop() {
        
        // 1.获取系统的Pop手势
        guard let systemGes = interactivePopGestureRecognizer else { return }
        
        // 2.获取手势添加到的View中
        guard let gesView = systemGes.view else { return }
        
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        guard let targetObjc = targets?.first else { return }
        
        // 3.2.取出target
        guard let target = targetObjc.value(forKey: "target") else { return }
        
        // 3.3.取出Action
        let action = Selector(("handleNavigationTransition:"))
        
        // 4.创建自己的Pan手势
        let panGes = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(panGes)
        panGes.addTarget(target, action: action)
    }
}

// MARK: - 返回点击事件
extension NavigationController {
    
    @objc private func backBtnDidClick() {
        popViewController(animated: true)
    }
}

