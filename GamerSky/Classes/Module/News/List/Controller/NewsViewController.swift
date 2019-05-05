//
//  NewsViewController.swift
//  GamerSky
//
//  Created by QY on 2018/4/2.
//  Copyright © 2018年 QY. All rights reserved.
//

import UIKit
import RxURLNavigator
import JXCategoryView

class NewsViewController: TableViewController {
    
    // MARK: - public
    private var nodeID = 0
    
    // MARK: - Lazyload
    private lazy var viewModel = NewsListViewModel(input: self)
    
    private lazy var headerView = NewsTableHeaderView.loadFromNib()
    
    convenience init(nodeID: Int) {
        self.init()
        self.nodeID = nodeID
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        headerView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: NewsTableHeaderView.height)
    }
    
    override func repeatClickTabBar() {
        print("\(self)")
    }
    
    override func makeUI() {
        super.makeUI()

        tableView.tableHeaderView = headerView
        tableView.register(cellType: ChannelListCell.self)
        tableView.rowHeight = ChannelListCell.cellHeight
        tableView.refreshHeader = RefreshHeader()
        tableView.refreshFooter = RefreshFooter()
        beginHeaderRefresh()
    }
    
    override func bindViewModel() {
        super.bindViewModel()

        let input = NewsListViewModel.Input(nodeID: nodeID)
        let output = viewModel.transform(input: input)

        output.items.drive(tableView.rx.items(cellIdentifier: ChannelListCell.ID, cellType: ChannelListCell.self)) { tableView, item, cell in
            cell.channel = item
        }
        .disposed(by: rx.disposeBag)

        output.banners
        .drive(headerView.rx.bannerData)
        .disposed(by: rx.disposeBag)
        
        tableView.rx.modelSelected(ChannelList.self)
        .map({URLNavigatorPushWrap(navigator, NavigationURL.contentDetail($0.contentId).path)})
        .bind(to: navigator.rx.push)
        .disposed(by: rx.disposeBag)
    }
}
