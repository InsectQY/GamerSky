//
//  GameSellListViewController.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/17.
//Copyright © 2018年 QY. All rights reserved.
//

import UIKit
import JXCategoryView

class GameSellListViewController: ViewController {
    
    private var date: Int = 0
    // MARK: - LazyLoad
    private lazy var tableView: TableView = {
        
        let tableView = TableView(frame: view.bounds)
        tableView.register(cellType: GameSellListCell.self)
        tableView.rowHeight = GameSellListCell.cellHeight
        tableView.refreshHeader = RefreshHeader()
        return tableView
    }()
    
    private lazy var viewModel = GameSellListViewModel()
    private lazy var vmOutput = viewModel.transform(input: vmInput)
    private lazy var vmInput = GameSellListViewModel.Input(date: date, headerRefresh: tableView.refreshHeader.rx.refreshing.asDriver())
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    convenience init(date: Int) {
        self.init()
        self.date = date
    }
    
    override func makeUI() {
        super.makeUI()
        view.addSubview(tableView)
        tableView.refreshHeader.beginRefreshing()
    }
    
    override func bindViewModel() {
        
        vmOutput.vmDatas.drive(tableView.rx.items) { (tableView, row, item) in
            
            let cell = tableView.dequeueReusableCell(for: IndexPath(row: row, section: 0), cellType: GameSellListCell.self)
            cell.item = item
            return cell
        }.disposed(by: rx.disposeBag)
        
        // 刷新状态
        vmOutput.endHeaderRefresh
        .drive(tableView.refreshHeader.rx.isRefreshing)
        .disposed(by: rx.disposeBag)
    }
}

// MARK: - JXCategoryListContentViewDelegate
extension GameSellListViewController: JXCategoryListContentViewDelegate {

    func listView() -> UIView! {
        return view
    }
}
