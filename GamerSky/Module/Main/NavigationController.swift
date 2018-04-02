//
//  NavigationController.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/5/23.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit
import FDFullscreenPopGesture

class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fd_fullscreenPopGestureRecognizer.isEnabled = true
        
        // 导航栏背景和文字设置
        let naviBar: UINavigationBar = UINavigationBar.appearance()
        naviBar.barTintColor = .white
        naviBar.backgroundColor = .white
        
        view.backgroundColor = .white
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if childViewControllers.count >= 1 {
            
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "common_Icon_Back_20x20_Black"), style: .plain, target: self, action: #selector(backBtnDidClick))
            // 隐藏要push的控制器的tabbar
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: animated)
    }
}

// MARK: - 返回点击事件
extension NavigationController {
    
    @objc private func backBtnDidClick() {
        popViewController(animated: true)
    }
}
