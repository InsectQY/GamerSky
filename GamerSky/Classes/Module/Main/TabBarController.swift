//
//  TabBarController.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/5/23.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit
import SwiftTheme

class TabBarController: UITabBarController {
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTabBar()
        seUpTabBarAttr()

        guard let jsonPath = Bundle.main.path(forResource: "MainVCSettings.json", ofType: nil) else {
            
            print("没有获取到对应的文件路径")
            return
        }
        
        guard let jsonData = try? Data(contentsOf: URL(fileURLWithPath: jsonPath)) else {
            print("没有获取到json文件中数据")
            return
        }
        
        guard let anyObject = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) else {
            return
        }
        
        guard let dictArray = anyObject as? [[String: AnyObject]] else {
            return
        }
        
        for dict in dictArray {
            
            guard let vcName = dict["vcName"] as? String else {continue}
            guard let normalImg = dict["normalImg"] as? String else {continue}
            guard let selImg = dict["selImg"] as? String else {continue}
            
            addChildVc(childVcName: vcName, normalImg: normalImg, selImg: selImg)
        }
    }
}

// MARK: - 设置 TabBar 属性
extension TabBarController {
    
    private func setUpTabBar() {
        
        let tabBar = TabBar()
        tabBar.theme_barTintColor = "colors.tabbarTintColor"
        setValue(tabBar, forKey: "tabBar")
    }
    
    private func seUpTabBarAttr() {
    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.darkGray], for: .selected)
    }
}

// MARK: - 设置子控制器
extension TabBarController {
    
    private func addChildVc(childVcName: String, normalImg: String, selImg: String) {
        
        let childVc = GetVc.getVcFromString(childVcName)
        childVc.tabBarItem.image = UIImage(named: normalImg)
        childVc.tabBarItem.selectedImage = UIImage(named: selImg)
        childVc.tabBarItem.imageInsets = UIEdgeInsets.init(top: 6, left: 0, bottom: -6, right: 0)
        
        let childNav = NavigationController(rootViewController: childVc)
        
        addChild(childNav)
    }
}
