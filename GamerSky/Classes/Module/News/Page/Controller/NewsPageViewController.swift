//
//  NewsPageViewController.swift
//  GamerSky
//
//  Created by Insect on 2018/4/2.
//  Copyright © 2018年 QY. All rights reserved.
//

import UIKit
import JXCategoryView

class NewsPageViewController: ViewController {
    
    private let contentHeight: CGFloat = ScreenHeight - kTopH - KBottomH
    
    fileprivate lazy var categoryView: JXCategoryTitleView = {
        
        let lineView = JXCategoryIndicatorLineView()
        lineView.lineStyle = .JD
        lineView.indicatorLineWidth = 10
        let categoryView = JXCategoryTitleView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: kNaviBarH))
        categoryView.contentScrollView = pageContentView.collectionView
        categoryView.indicators = [lineView]
        return categoryView
    }()
    
    fileprivate lazy var pageContentView: PageContentView = {
        
        let pageContentView = PageContentView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: contentHeight), childVcs: [])
        return pageContentView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavi()
        loadAllChannel()
    }
    
    override func makeUI() {
        
        super.makeUI()
        edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        view.addSubview(pageContentView)
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
            
            vc.pageContentView.childVcs = result.map({NewsViewController(nodeID: $0.nodeId)})
            vc.categoryView.titles = result.map({$0.nodeName})
            vc.categoryView.reloadData()
        }
    }
}
