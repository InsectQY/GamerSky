//
//  NewsPageViewController.swift
//  GamerSky
//
//  Created by Insect on 2018/4/2.
//  Copyright © 2018年 QY. All rights reserved.
//

import UIKit
import YNPageViewController

class NewsPageViewController: YNPageViewController {
    
    static public func pageVC() -> NewsPageViewController {

        let vcs: [NewsViewController] = [NewsViewController()]
        let titles: [String] = ["111"]

        let configration = YNPageConfigration.defaultConfig()
        configration?.pageStyle = .navigation
        configration?.showTabbar = true
        configration?.showNavigation = true
        configration?.showBottomLine = true
        
        let navPageVC = NewsPageViewController(controllers: vcs, titles: titles, config: configration)
        navPageVC?.dataSource = navPageVC
        return navPageVC!
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

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
        .subscribe(onNext: { [weak self] in

            guard let `self` = self else {return}
//            self.allChannel = $0
            
            let childVcs = $0.map({NewsViewController(nodeID: $0.nodeId)})
            let titles = $0.map({$0.nodeName})
            self.insertPageChildControllers(withTitles: titles, controllers: childVcs, index: 0)
        }, onError: {
             print("失败----\($0)")
        })
        .disposed(by: rx.disposeBag)
    }
}

extension NewsPageViewController {
    
    // MARK: - 设置导航栏
    private func setUpNavi() {

        navigationItem.rightBarButtonItem = UIBarButtonItem(image:#imageLiteral(resourceName: "common_Icon_Search_16x16"), style: .plain, target: self, action: #selector(didClickSearch))
    }
    
    // MARK: - 点击了搜索
    @objc private func didClickSearch() {
        
    }
}

// MARK: - YNPageViewControllerDataSource
extension NewsPageViewController: YNPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: YNPageViewController!, pageFor index: Int) -> UIScrollView! {
        
        guard let vc = pageViewController.controllersM()[index] as? NewsViewController else {return UIScrollView()}
        return vc.tableView
    }
}
