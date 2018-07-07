//
//  NewsViewController.swift
//  GamerSky
//
//  Created by QY on 2018/4/2.
//  Copyright © 2018年 QY. All rights reserved.
//

import UIKit
import SwiftNotificationCenter
import RxSwift
import URLNavigator
import RxDataSources

class NewsViewController: BaseViewController {
    
    // MARK: - public
    public var nodeID = 0
    
    // MARK: - Lazyload
    private var dataSource: RxTableViewSectionedReloadDataSource<NewsListSection>!
    
    private lazy var viewModel = NewsListViewModel()
    
    private lazy var vmOutput: NewsListViewModel.NewsListOutput = {
        
        let vmOutput = viewModel.transform(input: NewsListViewModel.Input(nodeID: nodeID))
        return vmOutput
    }()

    private lazy var tableView: UITableView = {
        
        let tableView = BaseTableView(frame: UIScreen.main.bounds, style: .grouped)
        tableView.separatorStyle = .none
        tableView.register(cellType: ChannelListCell.self)
        tableView.register(headerFooterViewType: NewsSectionHeaderView.self)
        tableView.contentInset = UIEdgeInsetsMake(kTopH, 0, KBottomH, 0)
        tableView.scrollIndicatorInsets = UIEdgeInsetsMake(kTopH, 0, KBottomH, 0)
        tableView.tableHeaderView = headerView
        tableView.rowHeight = ChannelListCell.cellHeight
        tableView.delegate = self
        return tableView
    }()
    
    private lazy var headerView: NewsTableHeaderView = {
        
        let headerView = NewsTableHeaderView.loadFromNib()
        headerView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight * 0.31)
        return headerView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavi()
        setUpUI()
        bindUI()
        setUpRefresh()
    }
    
    override func repeatClickTabBar() {
        print("\(self)")
    }
}

extension NewsViewController {
    
    private func setUpUI() {
        view.addSubview(tableView)
    }
    
    private func setUpNavi() {
        automaticallyAdjustsScrollViewInsets = false
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
        
        vmOutput.banners.asDriver()
        .drive(headerView.rx.bannerData)
        .disposed(by: rx.disposeBag)
        
        tableView.rx.modelSelected(ChannelList.self).subscribe(onNext: {
            
            navigator
            .push(NavigationURL.get(.contentDetail($0.contentId)))
        }).disposed(by: rx.disposeBag)
    }
}

extension NewsViewController: Refreshable {
    
    private func setUpRefresh() {
        
        let refreshHeader = initRefreshHeader(tableView) { [weak self] in
            self?.vmOutput.requestCommand.onNext(true)
        }
        let refreshFooter = initRefreshFooter(tableView) { [weak self] in
            self?.vmOutput.requestCommand.onNext(false)
        }
        vmOutput.autoSetRefreshHeaderStatus(header: refreshHeader, footer: refreshFooter).disposed(by: rx.disposeBag)
        refreshHeader.beginRefreshing()
    }
}

// MARK: - UITableViewDelegate
extension NewsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let headerView = tableView.dequeueReusableHeaderFooterView(NewsSectionHeaderView.self)
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return NewsSectionHeaderView.height
    }
}
