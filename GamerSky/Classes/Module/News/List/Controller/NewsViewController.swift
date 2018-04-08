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
    public  var nodeID = 0
    
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
        tableView.rowHeight = ScreenWidth * 0.22
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
        
        tableView.mj_header = QYRefreshHeader { [weak self] in
            
            guard let strongSelf = self else {return}
            strongSelf.page = 1
            strongSelf.tableView.mj_footer.endRefreshing()
            ApiProvider.request(.allChannelList(strongSelf.page, strongSelf.nodeID), objectModel: BaseModel<[ChannelList]>.self, success: {
                
                strongSelf.channelListAry = $0.result
                strongSelf.headerView.channelListAry = $0.result.first?.childElements
                strongSelf.channelListAry.removeFirst()
                strongSelf.tableView.reloadData()
                strongSelf.tableView.mj_footer.isHidden = false
                strongSelf.tableView.mj_header.endRefreshing()
            }) { _ in
                strongSelf.tableView.mj_header.endRefreshing()
            }
        }

        tableView.mj_footer = QYRefreshFooter { [weak self] in
            
            guard let strongSelf = self else {return}
            strongSelf.page += 1
            strongSelf.tableView.mj_header.endRefreshing()
            ApiProvider.request(.allChannelList(strongSelf.page, strongSelf.nodeID), objectModel: BaseModel<[ChannelList]>.self, success: {
                
                strongSelf.channelListAry += $0.result
                strongSelf.tableView.reloadData()
                strongSelf.tableView.mj_footer.endRefreshing()
            }) { _ in
                strongSelf.tableView.mj_footer.endRefreshing()
            }
        }
        
        tableView.mj_footer.isHidden = true
        tableView.mj_header.beginRefreshing()
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
        return 20
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = ContentDetailViewController(ID: channelListAry[indexPath.row].contentId)
        navigationController?.pushViewController(vc, animated: true)
    }
}
