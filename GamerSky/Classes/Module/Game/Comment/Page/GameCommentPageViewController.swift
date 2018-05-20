//
//  GamePageViewController.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/22.
//Copyright © 2018年 QY. All rights reserved.
//

import UIKit
import DNSPageView

class GameCommentPageViewController: BaseViewController {
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavi()
        setUpPageView()
    }
}

// MARK: - 设置 UI 界面
extension GameCommentPageViewController {
    
    private func setUpNavi() {
        
        title = "玩家点评"
        automaticallyAdjustsScrollViewInsets = false
    }
    
    private func setUpPageView() {
        
        // 创建DNSPageStyle，设置样式
        let style = DNSPageStyle()
        style.bottomLineHeight = 2
        style.isShowBottomLine = true
        style.titleFontSize = 18
        style.bottomLineColor = MainColor
        style.titleColor = .black
        style.titleSelectedColor = MainColor
        
        // 创建每一页对应的controller
        var childViewControllers = [GameCommentListViewController]()
        let commentStrings = ["热门", "最新"]
        let commentType: [GameCommentType] = [.hot, .latest]
        
        for i in 0..<commentStrings.count {
            
            let controller = GameCommentListViewController()
            controller.commentType = commentType[i]
            childViewControllers.append(controller)
        }
        
        // 创建对应的DNSPageView，并设置它的frame
        let pageView = DNSPageView(frame: CGRect(x: 0, y: kTopH, width: ScreenWidth, height: ScreenHeight), style: style, titles: commentStrings, childViewControllers: childViewControllers)
        view.addSubview(pageView)
    }
}
