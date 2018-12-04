//
//  RankingPageViewController.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/19.
//Copyright © 2018年 QY. All rights reserved.
//

import UIKit
import JXCategoryView

class GameRankingPageViewController: BaseViewController {
    
    private let menuHeight: CGFloat = 44
    private var contentHeight: CGFloat {
        return ScreenHeight - kTopH - menuHeight
    }
    
    private lazy var categoryView: JXCategoryTitleView = {
        
        let lineView = JXCategoryIndicatorLineView()
        lineView.lineStyle = .JD
        lineView.indicatorLineWidth = 10
        let categoryView = JXCategoryTitleView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: menuHeight))
        categoryView.contentScrollView = pageContentView.collectionView
        categoryView.indicators = [lineView]
        categoryView.titles = pageData.map({$0.name})
        return categoryView
    }()
    
    private lazy var pageContentView: PageContentView = {
        
        let childVcs = pageData.map({GameRankingListViewController(gameClassID: $0.searchid, rankingType: .fractions)})
        let pageContentView = PageContentView(frame: CGRect(x: 0, y: menuHeight, width: ScreenWidth, height: contentHeight), childVcs: childVcs)
        return pageContentView
    }()
    
    private lazy var pageData = [GameTag]()
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPageData()
    }
}

// MARK: - 加载本地数据
extension GameRankingPageViewController {
    
    private func loadPageData() {
        
        let data = try! Data(contentsOf: Bundle.main.url(forResource: "GameCategoryData", withExtension: "plist")!)
        pageData = try! PropertyListDecoder().decode([GameTag].self, from: data)
        setUpUI()
    }
    
    private func setUpUI() {
        
        edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        view.addSubview(pageContentView)
        view.addSubview(categoryView)
    }
}
