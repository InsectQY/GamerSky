//
//  TabBar.swift
//  BookShopkeeper
//
//  Created by engic on 2018/1/5.
//  Copyright © 2018年 dingding. All rights reserved.
//

import UIKit
import SwiftNotificationCenter

protocol TabBarProtocol {
    func tabBarRepeatClick()
}

class TabBar: UITabBar {

    private var previousTabBarButton: UIControl = UIControl()
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        // 添加重复点击事件
        for tabBarButton in subviews {
            
            if tabBarButton.isKind(of: NSClassFromString("UITabBarButton")!) {
                
                if let tabBarButton = tabBarButton as? UIControl {
                    tabBarButton.addTarget(self, action: #selector(tabBarDidClick(_:)), for: .touchUpInside)
                }
            }
        }
    }

    @objc private func tabBarDidClick(_ tabBarButton: UIControl) {
        
        if previousTabBarButton == tabBarButton {

            Broadcaster.notify(TabBarProtocol.self) {
                $0.tabBarRepeatClick()
            }
        }
        previousTabBarButton = tabBarButton
    }
}
