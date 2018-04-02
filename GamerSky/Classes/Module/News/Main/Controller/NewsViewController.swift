//
//  NewsViewController.swift
//  GamerSky
//
//  Created by engic on 2018/4/2.
//  Copyright © 2018年 engic. All rights reserved.
//

import UIKit
import SwiftNotificationCenter

class NewsViewController: BaseViewController {

    private var page = 1
    
    private lazy var channelListAry = [ChannelList]()
    private lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: UIScreen.main.bounds)
        tableView.rowHeight = ScreenWidth * 0.22
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(cellType: ChannelListCell.self)
        tableView.contentInset = UIEdgeInsetsMake(kTopH, 0, KBottomH, 0)
        tableView.scrollIndicatorInsets = UIEdgeInsetsMake(kTopH, 0, KBottomH, 0)
        return tableView
    }()
    
    private lazy var headerView: NewsTableHeaderView = {
        
        let headerView = NewsTableHeaderView.loadFromNib()
        headerView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight * 0.3)
        return headerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavi()
        setUpUI()
        loadAllChannel()
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
//        navigationItem.rightBarButtonItem = UIBarButtonItem()
    }
    
    // MARK: - 设置刷新
    private func setUpRefresh() {
        
        tableView.mj_header = QYRefreshHeader(refreshingTarget: self, refreshingAction: #selector(loadNewChannelLists))
        tableView.mj_footer = QYRefreshFooter(refreshingTarget: self, refreshingAction: #selector(loadMoreChannelLists))
        tableView.mj_header.beginRefreshing()
    }
    
    // MARK: - 设置头部视图
    private func setUpHeaderView() {
    
        tableView.tableHeaderView = headerView
    }
}

// MARK: - 网络请求
extension NewsViewController {
    
    // MARK: - 加载频道数据
    private func loadAllChannel() {
       
        ApiProvider.request(.allChannel, objectModel: BaseModel<[Channel]>.self, success: {
            print("成功----\($0)")
        }) {
            print("失败----\($0)")
        }
    }
    
    @objc private func loadNewChannelLists() {
        
        page = 1
        tableView.mj_footer.endRefreshing()
        ApiProvider.request(.allChannelList(page), objectModel: BaseModel<[ChannelList]>.self, success: {
            
            self.channelListAry = $0.result
            self.headerView.channelListAry = $0.result.first?.childElements
            self.channelListAry.removeFirst()
            self.tableView.reloadData()
            self.tableView.mj_header.endRefreshing()
        }) { _ in
            self.tableView.mj_header.endRefreshing()
        }
    }
    
    @objc private func loadMoreChannelLists() {
        
        page += 1
        tableView.mj_header.endRefreshing()
        ApiProvider.request(.allChannelList(page), objectModel: BaseModel<[ChannelList]>.self, success: {
            
            self.channelListAry += $0.result
            self.tableView.reloadData()
            self.tableView.mj_footer.endRefreshing()
        }) { _ in
            self.tableView.mj_footer.endRefreshing()
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = ContentDetailViewController()
        vc.contentID = channelListAry[indexPath.row].contentId
        navigationController?.pushViewController(vc, animated: true)
    }
}
