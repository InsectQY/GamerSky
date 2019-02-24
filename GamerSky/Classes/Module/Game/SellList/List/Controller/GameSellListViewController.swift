//
//  GameSellListViewController.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/17.
//Copyright © 2018年 QY. All rights reserved.
//

import UIKit
import JXCategoryView

class GameSellListViewController: TableViewController {
    
    private var date: Int = 0
    // MARK: - LazyLoad
    private lazy var viewModel = GameSellListViewModel()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    convenience init(date: Int) {
        self.init()
        self.date = date
    }
    
    override func makeUI() {
        super.makeUI()

        tableView.register(cellType: GameSellListCell.self)
        tableView.rowHeight = GameSellListCell.cellHeight
        tableView.refreshHeader = RefreshHeader()
        beginHeaderRefresh()
    }
    
    override func bindViewModel() {

        super.bindViewModel()

        let input = GameSellListViewModel.Input(date: date, headerRefresh: tableView.refreshHeader.rx.refreshing.asDriver())
        let output = viewModel.transform(input: input)

        output.vmDatas.drive(tableView.rx.items(cellIdentifier: GameSellListCell.ID, cellType: GameSellListCell.self)) { tableView, item, cell in
            cell.item = item
        }.disposed(by: rx.disposeBag)
        
        // 刷新状态
        output.endHeaderRefresh
        .drive(tableView.refreshHeader.rx.isRefreshing)
        .disposed(by: rx.disposeBag)
    }
}
