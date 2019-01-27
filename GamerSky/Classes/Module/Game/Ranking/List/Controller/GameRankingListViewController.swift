//
//  GameRankingListViewController.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/19.
//Copyright © 2018年 QY. All rights reserved.
//

import UIKit

class GameRankingListViewController: ViewController {
    
    /// 游戏种类 ID
    private var gameClassID = 0
    /// 年代
    private var annualClass = "all"
    /// 排名方式
    private var rankingType: GameRankingType = .fractions

    // MARK: - LazyLoad
    private lazy var rankingData = [GameSpecialDetail]()
    
    private lazy var viewModel = GameRankingListViewModel()
    private lazy var vmInput = GameRankingListViewModel.Input(gameClassID: gameClassID, annualClass: annualClass, headerRefresh: tableView.qy_header.rx.refreshing.asDriver(), footerRefresh: tableView.qy_footer.rx.refreshing.asDriver())
    private lazy var vmOutput = viewModel.transform(input: vmInput)
    
    private lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: view.bounds)
        tableView.delegate = self
        tableView.register(cellType: GameColumnDetailCell.self)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.qy_header = QYRefreshHeader()
        tableView.qy_footer = QYRefreshFooter()
        return tableView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        bindUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    convenience init(gameClassID: Int, rankingType: GameRankingType) {
        
        self.init()
        self.gameClassID = gameClassID
        self.rankingType = rankingType
    }
}

// MARK: - 设置 UI 界面
extension GameRankingListViewController {
    
    private func setUpUI() {
        
        view.addSubview(tableView)
        tableView.qy_header.beginRefreshing()
    }
    
    private func bindUI() {
        
        vmOutput.vmDatas.drive(tableView.rx.items) { (tableView, row, item) in
            
            let cell = tableView.dequeueReusableCell(for: IndexPath(row: row, section: 0), cellType: GameColumnDetailCell.self)
            cell.descLabelBottomConstraint.constant = 0
            cell.tag = row
            cell.specitial = item
            return cell
        }.disposed(by: rx.disposeBag)
        
        // 刷新状态
        vmOutput.endHeaderRefresh
        .drive(tableView.qy_header.rx.isRefreshing)
        .disposed(by: rx.disposeBag)
        
        vmOutput.endFooterRefresh
        .drive(tableView.qy_footer.rx.refreshFooterState)
        .disposed(by: rx.disposeBag)
    }
}

// MARK: - UITableViewDelegate
extension GameRankingListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
