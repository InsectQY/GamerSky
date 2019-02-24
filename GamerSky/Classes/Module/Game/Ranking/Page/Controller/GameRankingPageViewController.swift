//
//  RankingPageViewController.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/19.
//Copyright © 2018年 QY. All rights reserved.
//

import UIKit
import JXCategoryView

class GameRankingPageViewController: ViewController {
    
    private let menuHeight: CGFloat = 44

    private lazy var categoryView: JXCategoryTitleView = {
        
        let lineView = JXCategoryIndicatorLineView()
        lineView.lineStyle = .JD
        lineView.indicatorLineWidth = 10
        let categoryView = JXCategoryTitleView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: menuHeight))
        categoryView.contentScrollView = listContainerView.scrollView
        categoryView.indicators = [lineView]
        categoryView.delegate = self
        return categoryView
    }()

    // swiftlint:disable force_unwrapping
    fileprivate lazy var listContainerView = JXCategoryListContainerView(delegate: self)!
    
    private lazy var pageData = [GameTag]()
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPageData()
    }
    
    override func makeUI() {
        
        super.makeUI()
        edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        view.addSubview(listContainerView)
        view.addSubview(categoryView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        categoryView.frame = CGRect(x: 0, y: 0, width: view.width, height: menuHeight)
        listContainerView.frame = CGRect(x: 0, y: menuHeight, width: view.width, height: view.height)
    }
}

// MARK: - 加载本地数据
extension GameRankingPageViewController {
    
    private func loadPageData() {
        
        let data = try! Data(contentsOf: Bundle.main.url(forResource: "GameCategoryData", withExtension: "plist")!)
        pageData = try! PropertyListDecoder().decode([GameTag].self, from: data)
        categoryView.titles = pageData.map{ $0.name }
    }
}

// MARK: - JXCategoryViewDelegate
extension GameRankingPageViewController: JXCategoryViewDelegate {

    func categoryView(_ categoryView: JXCategoryBaseView!, didSelectedItemAt index: Int) {
        listContainerView.didClickSelectedItem(at: index)
    }

    func categoryView(_ categoryView: JXCategoryBaseView!, scrollingFromLeftIndex leftIndex: Int, toRightIndex rightIndex: Int, ratio: CGFloat) {
        listContainerView.scrolling(fromLeftIndex: leftIndex, toRightIndex: rightIndex, ratio: ratio, selectedIndex: categoryView.selectedIndex)
    }
}

// MARK: - JXCategoryListContainerViewDelegate
extension GameRankingPageViewController: JXCategoryListContainerViewDelegate {

    func number(ofListsInlistContainerView listContainerView: JXCategoryListContainerView!) -> Int {
        return pageData.count
    }

    func listContainerView(_ listContainerView: JXCategoryListContainerView!, initListFor index: Int) -> JXCategoryListContentViewDelegate! {
        return GameRankingListViewController(gameClassID: pageData[index].searchid, rankingType: .fractions)
    }
}
