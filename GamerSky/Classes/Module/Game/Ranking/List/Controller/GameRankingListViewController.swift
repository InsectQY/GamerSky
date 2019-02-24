//
//  GameRankingListViewController.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/19.
//Copyright © 2018年 QY. All rights reserved.
//

import UIKit
import JXCategoryView

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
    private lazy var vmInput = GameRankingListViewModel.Input(gameClassID: gameClassID, annualClass: annualClass, headerRefresh: tableView.refreshHeader.rx.refreshing.asDriver(), footerRefresh: tableView.refreshFooter.rx.refreshing.asDriver())
    private lazy var vmOutput = viewModel.transform(input: vmInput)
    
    private lazy var tableView: TableView = {
        
        let tableView = TableView(frame: view.bounds)
        tableView.delegate = self
        tableView.register(cellType: GameColumnDetailCell.self)
        tableView.refreshHeader = RefreshHeader()
        tableView.refreshFooter = RefreshFooter()
        return tableView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    override func makeUI() {
        
        super.makeUI()
        view.addSubview(tableView)
        tableView.refreshHeader.beginRefreshing()
    }
    
    override func bindViewModel() {
        
        vmOutput.vmDatas.drive(tableView.rx.items) { (tableView, row, item) in
            
            let cell = tableView.dequeueReusableCell(for: IndexPath(row: row, section: 0), cellType: GameColumnDetailCell.self)
            cell.descLabelBottomConstraint.constant = 0
            cell.tag = row
            cell.specitial = item
            return cell
        }.disposed(by: rx.disposeBag)
        
        // 刷新状态
        vmOutput.endHeaderRefresh
        .drive(tableView.refreshHeader.rx.isRefreshing)
        .disposed(by: rx.disposeBag)
        
        vmOutput.endFooterRefresh
        .drive(tableView.refreshFooter.rx.refreshFooterState)
        .disposed(by: rx.disposeBag)
    }
}

// MARK: - UITableViewDelegate
extension GameRankingListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
