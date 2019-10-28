//
//  NewsPageViewController.swift
//  GamerSky
//
//  Created by Insect on 2018/4/2.
//  Copyright © 2018年 QY. All rights reserved.
//

import UIKit
import JXCategoryView

class NewsPageViewController: ViewController<NewsPageViewModel> {
    
    fileprivate lazy var categoryView: JXCategoryTitleView = {
        
        let lineView = JXCategoryIndicatorLineView()
        lineView.lineStyle = .lengthen
        lineView.indicatorWidth = 10
        let categoryView = JXCategoryTitleView(frame: CGRect(x: 0, y: 0, width: Configs.Dimensions.screenWidth, height: Configs.Dimensions.naviBarHeight))
        categoryView.contentScrollView = listContainerView.scrollView
        categoryView.indicators = [lineView]
        categoryView.delegate = self
        return categoryView
    }()
    
    // swiftlint:disable force_unwrapping
    fileprivate lazy var listContainerView = JXCategoryListContainerView(type: .scrollView, delegate: self)!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavi()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        listContainerView.frame = view.bounds
    }

    override func makeUI() {
        
        super.makeUI()
        edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        view.addSubview(listContainerView)
    }

    override func bindViewModel() {
        super.bindViewModel()
        viewModel.transform(input: NewsPageViewModel.Input())

        viewModel.category.asDriver()
        .drive(rx.channel)
        .disposed(by: rx.disposeBag)
    }
}

extension NewsPageViewController {
    
    // MARK: - 设置导航栏
    private func setUpNavi() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image:#imageLiteral(resourceName: "common_Icon_Search_16x16"), style: .plain, target: self, action: #selector(didClickSearch))
        navigationItem.titleView = categoryView
    }
    
    // MARK: - 点击了搜索
    @objc private func didClickSearch() {
        
    }
}

// MARK: - JXCategoryViewDelegate
extension NewsPageViewController: JXCategoryViewDelegate {

    func categoryView(_ categoryView: JXCategoryBaseView!, didSelectedItemAt index: Int) {
        listContainerView.didClickSelectedItem(at: index)
    }

    func categoryView(_ categoryView: JXCategoryBaseView!, scrollingFromLeftIndex leftIndex: Int, toRightIndex rightIndex: Int, ratio: CGFloat) {
        listContainerView.scrolling(fromLeftIndex: leftIndex, toRightIndex: rightIndex, ratio: ratio, selectedIndex: categoryView.selectedIndex)
    }
}

// MARK: - JXCategoryListContainerViewDelegate
extension NewsPageViewController: JXCategoryListContainerViewDelegate {

    func number(ofListsInlistContainerView listContainerView: JXCategoryListContainerView!) -> Int {
        return viewModel.category.value.count
    }

    func listContainerView(_ listContainerView: JXCategoryListContainerView!, initListFor index: Int) -> JXCategoryListContentViewDelegate! {
        return NewsViewController(nodeID: viewModel.category.value[index].nodeId)
    }
}

extension Reactive where Base: NewsPageViewController {
    
    var channel: Binder<[Channel]> {
        
        return Binder(base) { (vc, result) in

            vc.categoryView.titles = result.map{ $0.nodeName }
            vc.categoryView.defaultSelectedIndex = 0
            vc.categoryView.reloadData()
            vc.listContainerView.reloadData()
        }
    }
}
