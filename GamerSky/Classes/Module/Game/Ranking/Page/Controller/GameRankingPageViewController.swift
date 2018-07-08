//
//  RankingPageViewController.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/19.
//Copyright © 2018年 QY. All rights reserved.
//

import UIKit

class GameRankingPageViewController: BaseViewController {
    
    private lazy var pageData = [GameTag]()
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavi()
        loadPageData()
    }
}

// MARK: - 设置 UI 界面
extension GameRankingPageViewController {
    
    private func setUpNavi() {
        automaticallyAdjustsScrollViewInsets = false
    }
}

// MARK: - 加载本地数据
extension GameRankingPageViewController {
    
    private func loadPageData() {
        
        let data = try! Data(contentsOf: Bundle.main.url(forResource: "GameCategoryData", withExtension: "plist")!)
        pageData = try! PropertyListDecoder().decode([GameTag].self, from: data)
        setUpPageView()
    }
    
    private func setUpPageView() {
        
        // 创建DNSPageStyle，设置样式
        let style = DNSPageStyle()
        style.bottomLineHeight = 2
        style.isShowBottomLine = true
        style.titleFontSize = 16
        style.bottomLineColor = MainColor
        style.titleColor = .black
        style.titleSelectedColor = MainColor
        style.isTitleScrollEnable = true
        
        // 设置标题内容
        var titles = [String]()
        
        // 创建每一页对应的controller
        var childViewControllers = [GameRankingListViewController]()
        for element in pageData {
            
            let controller = GameRankingListViewController()
            controller.gameClass = element.searchid
            controller.rankingType = .fractions
            titles.append(element.name)
            childViewControllers.append(controller)
            addChildViewController(controller)
        }
        
        // 创建对应的DNSPageView，并设置它的frame
        let pageView = DNSPageView(frame: CGRect(x: 0, y: kTopH, width: ScreenWidth, height: ScreenHeight), style: style, titles: titles, childViewControllers: childViewControllers)
        view.addSubview(pageView)
    }
}
