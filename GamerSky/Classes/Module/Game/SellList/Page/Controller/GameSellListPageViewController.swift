//
//  SellListPageViewController.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/17.
//Copyright © 2018年 QY. All rights reserved.
//

import UIKit
import JXCategoryView

class GameSellListPageViewController: ViewController {
    
    private let menuHeight: CGFloat = 44
    private var contentHeight: CGFloat {
        return ScreenHeight - kTopH - menuHeight
    }
    
    // MARK: - LazyLoad
    private lazy var categoryView: JXCategoryTitleView = {
        
        let lineView = JXCategoryIndicatorLineView()
        lineView.lineStyle = .JD
        lineView.indicatorLineWidth = 10
        let categoryView = JXCategoryTitleView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: menuHeight))
        categoryView.contentScrollView = pageContentView.collectionView
        categoryView.indicators = [lineView]
        categoryView.titles = timeStrings
        return categoryView
    }()
    
    private lazy var pageContentView: PageContentView = {
        
        let childVcs = dates.map({GameSellListViewController(date: $0)})
        let pageContentView = PageContentView(frame: CGRect(x: 0, y: menuHeight, width: ScreenWidth, height: contentHeight), childVcs: childVcs)
        return pageContentView
    }()
    /// 中文的日期
    private lazy var timeStrings = [String]()
    /// 毫秒(用于获取数据)
    private lazy var dates = [Int]()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavi()
        getTime()
    }
}

// MARK: - 设置 UI 界面
extension GameSellListPageViewController {
    
    private func setUpUI() {
        
        edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        view.addSubview(pageContentView)
        view.addSubview(categoryView)
    }
    
    private func setUpNavi() {
        title = "发售表"
    }
    
    private func getTime() {
        
        // 遍历出去年和今年的12个月
        (-1...0).forEach { (year) in
            
            var date = Date()
            date.add(.year, value: year)
            (1...12).forEach { (month) in
                
                let timeString = "\(date.year)年\(month)月"
                timeStrings.append(timeString)
                // 时间戳(Unix13位时间戳)
                if let date = timeString.date(withFormat: "yyyy年MM月")?.timeIntervalSince1970 {
                    dates.append(Int(date) * 1000)
                }
            }
        }
        setUpUI()
    }
}
