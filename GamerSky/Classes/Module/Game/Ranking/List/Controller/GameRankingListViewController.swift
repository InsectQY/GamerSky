//
//  GameRankingListViewController.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/19.
//Copyright © 2018年 QY. All rights reserved.
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
        tableView.rowHeight = UITableView.automaticDimension
        tableView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: KBottomH + kTopH, right: 0)
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
            
            guard let `self` = self else {return}
            self.page = 1
            
            GameApi.gameRankingList(self.page, self.rankingType, self.gameClass, self.annualClass)
            .cache
            .request()
            .mapObject(BaseModel<[GameSpecialDetail]>.self)
            .subscribe(onNext: {
                
                self.rankingData = $0.result
                self.tableView.reloadData()
                self.tableView.qy_header.endRefreshing()
            }, onError: { _ in
                self.tableView.qy_header.endRefreshing()
            })
            .disposed(by: self.rx.disposeBag)
        })
        
        tableView.mj_footer = QYRefreshFooter(refreshingBlock: {[weak self] in
            
            guard let `self` = self else {return}
            self.page += 1
            
            GameApi.gameRankingList(self.page, self.rankingType, self.gameClass, self.annualClass)
            .cache
            .request()
            .mapObject(BaseModel<[GameSpecialDetail]>.self)
            .subscribe(onNext: {
                
                self.rankingData += $0.result
                self.tableView.reloadData()
                self.tableView.qy_footer.endRefreshing()
            }, onError: { _ in
                self.tableView.qy_footer.endRefreshing()
            })
            .disposed(by: self.rx.disposeBag)
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
