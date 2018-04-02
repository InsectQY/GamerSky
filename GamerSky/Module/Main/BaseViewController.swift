//
//  BaseViewController.swift
//  GamerSky
//
//  Created by engic on 2018/4/2.
//  Copyright © 2018年 engic. All rights reserved.
//

import UIKit
import SwiftNotificationCenter

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        registerNotification()
    }
    
    deinit {
        print("\(self)---销毁")
    }
    
    func repeatClickTabBar() {}
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
