//
//  GamePageViewController.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/22.
//Copyright © 2018年 QY. All rights reserved.
//

import UIKit
import JXCategoryView

class GameCommentPageViewController: ViewController {
    
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
        categoryView.titles = ["热门", "最新"]
        return categoryView
    }()
    
    private lazy var pageContentView: PageContentView = {
        
        let commentType: [GameCommentType] = [.hot, .latest]
        let childVcs = commentType.map({GameCommentListViewController(commentType: $0)})
        let pageContentView = PageContentView(frame: CGRect(x: 0, y: menuHeight, width: ScreenWidth, height: contentHeight), childVcs: childVcs)
        return pageContentView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavi()
    }
    
    override func makeUI() {
        
        super.makeUI()
        edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        view.addSubview(pageContentView)
        view.addSubview(categoryView)
    }
}

// MARK: - 设置 UI 界面
extension GameCommentPageViewController {
    
    private func setUpNavi() {
        
        title = "玩家点评"
    }
}
