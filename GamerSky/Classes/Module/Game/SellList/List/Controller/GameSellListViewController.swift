//
//  GameSellListViewController.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/17.
//Copyright © 2018年 QY. All rights reserved.
//

import UIKit

class GameSellListViewController: BaseViewController {
    
    public var date: Int = 0
    // MARK: - LazyLoad
    private lazy var gameSellLists = [GameSellList]()
    private lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: view.bounds)
        tableView.contentInset = UIEdgeInsetsMake(0, 0, KBottomH + kTopH, 0)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(cellType: GameSellListCell.self)
        tableView.rowHeight = GameSellListCell.cellHeight
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
extension GameSellListViewController {
    
    private func setUpUI() {
        automaticallyAdjustsScrollViewInsets = false
        view.addSubview(tableView)
    }
    
    private func setUpRefresh() {
        
        tableView.qy_header = QYRefreshHeader(refreshingBlock: { [weak self] in
            
            guard let `self` = self else {return}
            ApiProvider.request(.twoGameList(self.date, .popular), objectModel: BaseModel<[GameSellList]>.self, success: {
                
                self.gameSellLists = $0.result
                self.tableView.reloadData()
                self.tableView.qy_header.endRefreshing()
            }) { _ in
                self.tableView.qy_header.endRefreshing()
            }
        })
        
        tableView.qy_header.beginRefreshing()
    }
}

// MARK: - UITableViewDataSource
extension GameSellListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameSellLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GameSellListCell.self)
        cell.gameInfo = gameSellLists[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate
extension GameSellListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
