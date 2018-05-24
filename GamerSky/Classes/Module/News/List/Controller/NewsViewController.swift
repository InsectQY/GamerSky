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

class NewsViewController: BaseViewController {

    private var page = 1
    
    // MARK: - public
    public  var nodeID = 0
    
    // MARK: - Lazyload
    private lazy var channelListAry = [ChannelList]()
    private lazy var tableView: UITableView = {
        
        let tableView = BaseTableView(frame: UIScreen.main.bounds, style: .grouped)
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(cellType: ChannelListCell.self)
        tableView.register(headerFooterViewType: NewsSectionHeaderView.self)
        tableView.contentInset = UIEdgeInsetsMake(kTopH, 0, KBottomH, 0)
        tableView.scrollIndicatorInsets = UIEdgeInsetsMake(kTopH, 0, KBottomH, 0)
        tableView.rowHeight = ChannelListCell.cellHeight
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
    }
    
    override func repeatClickTabBar() {
        print("\(self)")
    }
}

extension NewsViewController {
    
    private func setUpUI() {
        
        view.addSubview(tableView)
        setUpHeaderView()
        setUpRefresh()
    }
    
    private func setUpNavi() {
        
        automaticallyAdjustsScrollViewInsets = false
    }
    
    // MARK: - 设置刷新
    private func setUpRefresh() {
        
        tableView.qy_header = QYRefreshHeader { [weak self] in
            
            guard let `self` = self else {return}
            self.page = 1
            self.tableView.qy_footer.endRefreshing()
            
            NewsApi.allChannelList(self.page, self.nodeID)
            .cache
            .request(objectModel: BaseModel<[ChannelList]>.self)
            .subscribe(onNext: {
                
                self.channelListAry = $0.result
                self.headerView.channelListAry = $0.result.first?.childElements
                self.channelListAry.removeFirst()
                self.tableView.reloadData()
                self.tableView.qy_header.endRefreshing()
            }, onError: { _ in
                 self.tableView.qy_header.endRefreshing()
            })
            .disposed(by: self.rx.disposeBag)
        }

        tableView.qy_footer = QYRefreshFooter { [weak self] in
            
            guard let `self` = self else {return}
            self.page += 1
            self.tableView.qy_header.endRefreshing()
            
            NewsApi.allChannelList(self.page, self.nodeID)
            .cache
            .request(objectModel: BaseModel<[ChannelList]>.self)
            .subscribe(onNext: {
                
                self.channelListAry += $0.result
                self.tableView.reloadData()
                self.tableView.qy_footer.endRefreshing()
            }, onError: { _ in
                self.tableView.qy_footer.endRefreshing()
            })
            .disposed(by: self.rx.disposeBag)
        }
        
        tableView.qy_header.beginRefreshing()
    }
    
    // MARK: - 设置头部视图
    private func setUpHeaderView() {
        tableView.tableHeaderView = headerView
    }
}

// MARK: - UITableViewDataSource
extension NewsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channelListAry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ChannelListCell.self)
        cell.channel = channelListAry[indexPath.row]
        return cell
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigator
        .push(NavigationURL.get(.contentDetail(channelListAry[indexPath.row].contentId)))
    }
}
