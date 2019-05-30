//
//  SellListPageViewController.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/17.
//Copyright © 2018年 QY. All rights reserved.
//

import UIKit
import JXCategoryView

class GameSellListPageViewController: ViewController<ViewModel> {
    
    private let menuHeight: CGFloat = 44

    // MARK: - LazyLoad
    private lazy var categoryView: JXCategoryTitleView = {
        
        let lineView = JXCategoryIndicatorLineView()
        lineView.lineStyle = .JD
        lineView.indicatorLineWidth = 10
        let categoryView = JXCategoryTitleView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: menuHeight))
        categoryView.contentScrollView = listContainerView.scrollView
        categoryView.delegate = self
        categoryView.indicators = [lineView]
        return categoryView
    }()

    // swiftlint:disable force_unwrapping
    fileprivate lazy var listContainerView = JXCategoryListContainerView(delegate: self)!

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
extension GameSellListPageViewController {
    
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
        makeUI()
        categoryView.titles = timeStrings
    }
}

// MARK: - JXCategoryViewDelegate
extension GameSellListPageViewController: JXCategoryViewDelegate {

    func categoryView(_ categoryView: JXCategoryBaseView!, didSelectedItemAt index: Int) {
        listContainerView.didClickSelectedItem(at: index)
    }

    func categoryView(_ categoryView: JXCategoryBaseView!, scrollingFromLeftIndex leftIndex: Int, toRightIndex rightIndex: Int, ratio: CGFloat) {
        listContainerView.scrolling(fromLeftIndex: leftIndex, toRightIndex: rightIndex, ratio: ratio, selectedIndex: categoryView.selectedIndex)
    }
}

// MARK: - JXCategoryListContainerViewDelegate
extension GameSellListPageViewController: JXCategoryListContainerViewDelegate {

    func number(ofListsInlistContainerView listContainerView: JXCategoryListContainerView!) -> Int {
        return dates.count
    }

    func listContainerView(_ listContainerView: JXCategoryListContainerView!, initListFor index: Int) -> JXCategoryListContentViewDelegate! {
        return GameSellListViewController(date: dates[index])
    }
}

