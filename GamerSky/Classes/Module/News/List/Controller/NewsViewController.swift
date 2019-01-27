//
//  NewsViewController.swift
//  GamerSky
//
//  Created by QY on 2018/4/2.
//  Copyright © 2018年 QY. All rights reserved.
//

import UIKit
import RxURLNavigator
import RxDataSources

class NewsViewController: ViewController {
    
    // MARK: - public
    private var nodeID = 0
    
    // MARK: - Lazyload
    private var dataSource: RxTableViewSectionedReloadDataSource<NewsListSection>!
    
    private lazy var viewModel = NewsListViewModel()
    private lazy var vmInput = NewsListViewModel.Input(nodeID: nodeID, headerRefresh: tableView.qy_header.rx.refreshing.asDriver(), footerRefresh: tableView.qy_footer.rx.refreshing.asDriver())
    private lazy var vmOutput = viewModel.transform(input: vmInput)

    private lazy var tableView: TableView = {
        
        let tableView = TableView(frame: view.bounds)
        tableView.separatorStyle = .none
        tableView.register(cellType: ChannelListCell.self)
        tableView.rowHeight = ChannelListCell.cellHeight
        tableView.qy_header = QYRefreshHeader()
        tableView.qy_footer = QYRefreshFooter()
        return tableView
    }()
    
    private lazy var headerView: NewsTableHeaderView = {
        
        let headerView = NewsTableHeaderView.loadFromNib()
        headerView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: NewsTableHeaderView.height)
        return headerView
    }()
    
    convenience init(nodeID: Int) {
        self.init()
        self.nodeID = nodeID
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        bindUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        tableView.tableHeaderView = headerView
    }
    
    override func repeatClickTabBar() {
        print("\(self)")
    }
}

extension NewsViewController {
    
    private func setUpUI() {
        
        view.addSubview(tableView)
        tableView.qy_header.beginRefreshing()
    }
}

extension NewsViewController {
    
    private func bindUI() {
        
        dataSource = RxTableViewSectionedReloadDataSource<NewsListSection>(configureCell: { (ds, tb, ip, item) -> UITableViewCell in
            
            let cell = tb.dequeueReusableCell(for: ip, cellType: ChannelListCell.self)
            cell.channel = item
            return cell
        })
        
        vmOutput.sections
        .drive(tableView.rx.items(dataSource: dataSource))
        .disposed(by: rx.disposeBag)
        
        vmOutput.banners
        .drive(headerView.rx.bannerData)
        .disposed(by: rx.disposeBag)
        
        tableView.rx.modelSelected(ChannelList.self)
        .map({URLNavigatorPushWrap(navigator, NavigationURL.contentDetail($0.contentId).path)})
        .bind(to: navigator.rx.push)
        .disposed(by: rx.disposeBag)
        
        vmOutput.endHeaderRefresh
        .drive(tableView.mj_header.rx.isRefreshing)
        .disposed(by: rx.disposeBag)
        
        vmOutput.endFooterRefresh
        .drive(tableView.mj_footer.rx.refreshFooterState)
        .disposed(by: rx.disposeBag)
    }
}
