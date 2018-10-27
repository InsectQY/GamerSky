//
//  NewsPageViewController.swift
//  GamerSky
//
//  Created by Insect on 2018/4/2.
//  Copyright © 2018年 QY. All rights reserved.
//

import UIKit
import Cache

class NewsPageViewController: BaseViewController {

    private var allChannel = [Channel]()
        
    private lazy var pageViewManager: DNSPageViewManager = {
        // 创建DNSPageStyle，设置样式
        let style = DNSPageStyle()
        style.isShowBottomLine = true
        style.isTitleScrollEnable = true
        style.bottomLineColor = MainColor
        style.titleColor = .darkGray
        style.titleSelectedColor = MainColor
        style.titleFontSize = 16
        style.titleViewBackgroundColor = UIColor.clear
        
        // 设置标题内容
        var titles = [String]()
        
        // 创建每一页对应的controller
        let childViewControllers: [NewsViewController] = allChannel.map { channel -> NewsViewController in
            
            titles.append(channel.nodeName)
            let controller = NewsViewController()
            controller.nodeID = channel.nodeId
            self.addChild(controller)
            return controller
        }
        
        return DNSPageViewManager(style: style, titles: titles, childViewControllers: childViewControllers)
    }()

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
        .mapObject(BaseModel<[Channel]>.self)
        .subscribe(onNext: { [weak self] in

            guard let `self` = self else {return}
            self.allChannel = $0.result
            self.navigationItem.titleView = self.pageViewManager.titleView
            self.pageViewManager.titleView.frame = CGRect(x: 0, y: 0, width: ScreenWidth - kNaviBarH, height: kNaviBarH)
            self.view.addSubview(self.pageViewManager.contentView)
            self.pageViewManager.contentView.frame = UIScreen.main.bounds
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
