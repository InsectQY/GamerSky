//
//  GameSellListViewController.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/17.
//Copyright © 2018年 QY. All rights reserved.
//

import UIKit
import JXCategoryView

class GameSellListViewController: TableViewController<GameSellListViewModel> {
    
    private var date: Int = 0
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(date: Int) {
        super.init(style: .plain)
        self.date = date
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func makeUI() {
        super.makeUI()

        tableView.register(cellType: GameSellListCell.self)
        tableView.rowHeight = GameSellListCell.cellHeight
        tableView.refreshHeader = RefreshHeader()
        tableView.refreshFooter = RefreshFooter()
        beginHeaderRefresh()
    }
    
    override func bindViewModel() {
        super.bindViewModel()

        let input = GameSellListViewModel.Input(date: date)
        let output = viewModel.transform(input: input)

        output.items.drive(tableView.rx.items(cellIdentifier: GameSellListCell.ID, cellType: GameSellListCell.self)) { tableView, item, cell in
            cell.item = item
        }
        .disposed(by: rx.disposeBag)
    }
}
