//
//  GameRankingListViewController.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/19.
//Copyright © 2018年 engic. All rights reserved.
//

import UIKit

class GameRankingListViewController: BaseViewController {
    
    /// 游戏种类 ID
    public var gameClass = 0
    /// 年代
    public var annualClass = "all"
    /// 排名方式
    public var rankingType = GameRankingType.fractions

    // MARK: - LazyLoad
    private lazy var rankingData = [GameSpecialDetail]()
    /// 页码
    private var page = 1
    
    private lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: GameColumnDetailCell.self)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.contentInset = UIEdgeInsetsMake(0, 0, KBottomH + kTopH, 0)
        tableView.separatorStyle = .none
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
extension GameRankingListViewController {
    
    private func setUpUI() {
        
        view.addSubview(tableView)
    }
}

extension GameRankingListViewController {
    
    private func setUpRefresh() {
        
        tableView.qy_header = QYRefreshHeader(refreshingBlock: { [weak self] in
            
            guard let strongSelf = self else {return}
            strongSelf.page = 1
            ApiProvider.request(.gameRankingList(strongSelf.page, strongSelf.rankingType, strongSelf.gameClass, strongSelf.annualClass), objectModel: BaseModel<[GameSpecialDetail]>.self, success: {
                
                strongSelf.rankingData = $0.result
                strongSelf.tableView.reloadData()
                strongSelf.tableView.qy_header.endRefreshing()
            }, failure: { _ in
                strongSelf.tableView.qy_header.endRefreshing()
            })
        })
        
        tableView.mj_footer = QYRefreshFooter(refreshingBlock: {[weak self] in
            
            guard let strongSelf = self else {return}
            strongSelf.page += 1
            ApiProvider.request(.gameRankingList(strongSelf.page, strongSelf.rankingType, strongSelf.gameClass, strongSelf.annualClass), objectModel: BaseModel<[GameSpecialDetail]>.self, success: {
                
                strongSelf.rankingData += $0.result
                strongSelf.tableView.reloadData()
                strongSelf.tableView.qy_footer.endRefreshing()
            }, failure: { _ in
                strongSelf.tableView.qy_footer.endRefreshing()
            })
        })
        
        tableView.qy_header.beginRefreshing()
    }
}

// MARK: - UITableViewDataSource
extension GameRankingListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rankingData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GameColumnDetailCell.self)
        cell.descLabelBottomConstraint.constant = 0
        cell.tag = indexPath.row
        cell.specitial = rankingData[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate
extension GameRankingListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
