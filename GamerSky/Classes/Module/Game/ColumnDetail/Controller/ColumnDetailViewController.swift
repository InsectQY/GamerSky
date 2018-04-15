//
//  ColumnDetailViewController.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/14.
//Copyright © 2018年 engic. All rights reserved.
//

import UIKit

class ColumnDetailViewController: BaseViewController {
    
    public var columnList: GameSpecialList?
    
    // MARK: - LazyLoad
    private lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .grouped)
        tableView.register(cellType: GameColumnDetailCell.self)
        tableView.register(headerFooterViewType: GameColumnDetailSectionHeader.self)
        tableView.contentInset = UIEdgeInsetsMake(kTopH, 0, 0, 0)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        return tableView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        setUpRefresh()
    }
}

// MARK: - 设置 UI 界面
extension ColumnDetailViewController {
    
    private func setUpUI() {
        
        view.addSubview(tableView)
    }
    
    private func setUpRefresh() {
        
        guard let columnList = columnList else {return}
        
        tableView.mj_header = QYRefreshHeader(refreshingBlock: { [weak self] in
            
            guard let strongSelf = self else {return}
            
            if columnList.hasSubList == true {
                
                
            }
            
            ApiProvider.request(.gameSpecialSubList(columnList.nodeId), objectModel: BaseModel<[GameSpecialSubList]>.self, success: { _ in
                strongSelf.tableView.mj_header.endRefreshing()
            }, failure: { _ in
                strongSelf.tableView.mj_header.endRefreshing()
            })
            
            ApiProvider.request(.gameSpecialDetail(1, columnList.nodeId), objectModel: BaseModel<[GameSpecialDetail]>.self, success: { _ in
                
                strongSelf.tableView.reloadData()
            }, failure: { _ in
                strongSelf.tableView.mj_header.endRefreshing()
            })
        })
    }
}

// MARK: - UITableViewDataSource
extension ColumnDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GameColumnDetailCell.self)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ColumnDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = tableView.dequeueReusableHeaderFooterView(GameColumnDetailSectionHeader.self)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return GameColumnDetailSectionHeader.sectionHeight
    }
}
