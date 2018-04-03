//
//  OriginalViewController.swift
//  GamerSky
//
//  Created by engic on 2018/4/2.
//  Copyright © 2018年 engic. All rights reserved.
//

import UIKit
import SwiftNotificationCenter
import SwiftTheme

class OriginalViewController: BaseViewController {

    private var page = 1
    private lazy var columnAry = [ColumnElement]()
    
    private lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: UIScreen.main.bounds)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(cellType: ColumnListCell.self)
        tableView.rowHeight = 250
        tableView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        tableView.contentInset = UIEdgeInsetsMake(kTopH, 0, 0, 0)
        tableView.scrollIndicatorInsets = UIEdgeInsetsMake(kTopH, 0, 0, 0)
        tableView.separatorStyle = .none
        return tableView
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

extension OriginalViewController {
    
    private func setUpUI() {
        
        view.addSubview(tableView)
        setUpRefresh()
    }
    
    // MARK: - 设置刷新
    private func setUpRefresh() {
        
        tableView.mj_header = QYRefreshHeader(refreshingTarget: self, refreshingAction: #selector(loadNewColumnContent))
        tableView.mj_footer = QYRefreshFooter(refreshingTarget: self, refreshingAction: #selector(loadMoreColumnContent))
        tableView.mj_header.beginRefreshing()
    }
    
    // MARK: - 设置导航栏
    private func setUpNavi() {
        
        automaticallyAdjustsScrollViewInsets = false
        let leftItem = UILabel(frame: CGRect(x: 10, y: 0, width: 300, height: kNaviBarH))
        leftItem.font = PFM18Font
        leftItem.text = "游民原创"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftItem)
    }
}

// MARK: - 网络请求
extension OriginalViewController {
    
    @objc private func loadNewColumnContent() {
        
        page = 1
        tableView.mj_footer.endRefreshing()
        ApiProvider.request(Api.columnContent(page, 47), objectModel: BaseModel<ColumnContent>.self, success: {
            
            self.columnAry = $0.result.childElements
            self.tableView.reloadData()
            self.tableView.mj_header.endRefreshing()
        }) { _ in
            self.tableView.mj_header.endRefreshing()
        }
    }
    
    @objc private func loadMoreColumnContent() {
        
        page += 1
        tableView.mj_header.endRefreshing()
        ApiProvider.request(Api.columnContent(page, 47), objectModel: BaseModel<ColumnContent>.self, success: {
            
            self.columnAry += $0.result.childElements
            self.tableView.reloadData()
            self.tableView.mj_footer.endRefreshing()
        }) { _ in
            self.tableView.mj_footer.endRefreshing()
        }
    }
}

// MARK: - UITableViewDataSource
extension OriginalViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return columnAry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ColumnListCell.self)
        cell.columnElement = columnAry[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate
extension OriginalViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
