//
//  NewsPageViewController.swift
//  GamerSky
//
//  Created by Insect on 2018/4/2.
//  Copyright © 2018年 QY. All rights reserved.
//

import UIKit
import JXCategoryView

class NewsPageViewController: BaseViewController {
    
    fileprivate let contentHeight: CGFloat = ScreenHeight - kTopH - KBottomH
    
    fileprivate lazy var scrollView: UIScrollView = {
        
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: contentHeight))
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    fileprivate lazy var categoryView: JXCategoryTitleView = {
        
        let lineView = JXCategoryIndicatorLineView()
        lineView.lineStyle = .JD
        lineView.indicatorLineWidth = 10
        let categoryView = JXCategoryTitleView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: kNaviBarH))
        categoryView.contentScrollView = scrollView
        categoryView.indicators = [lineView]
        return categoryView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        setUpNavi()
        loadAllChannel()
    }
}

// MARK: - 加载频道数据
extension NewsPageViewController {
    
    private func loadAllChannel() {
        
        NewsApi.allChannel
        .cache
        .request()
        .mapObject([Channel].self)
        .asDriver(onErrorJustReturn: [])
        .drive(rx.channel)
        .disposed(by: rx.disposeBag)
    }
}

extension NewsPageViewController {
    
    private func setUpUI() {
        
        edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        view.addSubview(scrollView)
        disablesAdjustScrollViewInsets(scrollView)
    }
    
    // MARK: - 设置导航栏
    private func setUpNavi() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image:#imageLiteral(resourceName: "common_Icon_Search_16x16"), style: .plain, target: self, action: #selector(didClickSearch))
        navigationItem.titleView = categoryView
    }
    
    // MARK: - 点击了搜索
    @objc private func didClickSearch() {
        
    }
}

extension Reactive where Base: NewsPageViewController {
    
    var channel: Binder<[Channel]> {
        
        return Binder(base) { (vc, result) in
            
            var titles: [String] = []
            for (index, value) in result.enumerated() {
                
                titles.append(value.nodeName)
                let listVC = NewsViewController(nodeID: value.nodeId)
                listVC.view.frame = CGRect(x: CGFloat(index) * ScreenWidth, y: 0, width: ScreenWidth, height: vc.contentHeight)
                vc.scrollView.addSubview(listVC.view)
                vc.addChild(listVC)
            }
            vc.categoryView.titles = titles
            vc.scrollView.contentSize = CGSize(width: ScreenWidth * CGFloat(titles.count), height: vc.contentHeight)
        }
    }
}
