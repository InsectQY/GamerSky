//
//  GamePageViewController.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/22.
//Copyright © 2018年 QY. All rights reserved.
//

import UIKit
import JXCategoryView

class GameCommentPageViewController: ViewController<ViewModel> {

    private let commentType: [GameCommentType] = [.hot, .latest]

    private let menuHeight: CGFloat = 44
    
    private lazy var categoryView: JXCategoryTitleView = {
        
        let lineView = JXCategoryIndicatorLineView()
        lineView.lineStyle = .JD
        lineView.indicatorLineWidth = 10
        let categoryView = JXCategoryTitleView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: menuHeight))
        categoryView.contentScrollView = listContainerView.scrollView
        categoryView.indicators = [lineView]
        categoryView.titles = ["热门", "最新"]
        categoryView.delegate = self
        return categoryView
    }()

    // swiftlint:disable force_unwrapping
    fileprivate lazy var listContainerView = JXCategoryListContainerView(delegate: self)!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavi()
    }
    
    override func makeUI() {
        
        super.makeUI()
        edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        view.addSubview(categoryView)
        view.addSubview(listContainerView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        categoryView.frame = CGRect(x: 0, y: 0, width: view.width, height: menuHeight)
        listContainerView.frame = CGRect(x: 0, y: menuHeight, width: view.width, height: view.height)
    }
}

// MARK: - 设置 UI 界面
extension GameCommentPageViewController {
    
    private func setUpNavi() {
        
        title = "玩家点评"
    }
}

// MARK: - JXCategoryListContainerViewDelegate
extension GameCommentPageViewController: JXCategoryListContainerViewDelegate {

    func number(ofListsInlistContainerView listContainerView: JXCategoryListContainerView!) -> Int {
        return commentType.count
    }

    func listContainerView(_ listContainerView: JXCategoryListContainerView!, initListFor index: Int) -> JXCategoryListContentViewDelegate! {
        return GameCommentListViewController(commentType: commentType[index])
    }
}

// MARK: - JXCategoryViewDelegate
extension GameCommentPageViewController: JXCategoryViewDelegate {

    func categoryView(_ categoryView: JXCategoryBaseView!, didSelectedItemAt index: Int) {
        listContainerView.didClickSelectedItem(at: index)
    }

    func categoryView(_ categoryView: JXCategoryBaseView!, scrollingFromLeftIndex leftIndex: Int, toRightIndex rightIndex: Int, ratio: CGFloat) {
        listContainerView.scrolling(fromLeftIndex: leftIndex, toRightIndex: rightIndex, ratio: ratio, selectedIndex: categoryView.selectedIndex)
    }
}

