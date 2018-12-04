//
//  GameSellListViewController.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/17.
//Copyright © 2018年 QY. All rights reserved.
//

import UIKit
import RxDataSources

class GameSellListViewController: BaseViewController {
    
    private var date: Int = 0
    // MARK: - LazyLoad
    private var dataSource: RxTableViewSectionedReloadDataSource<GameSellListSection>!
    private lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: view.bounds)
        tableView.register(cellType: GameSellListCell.self)
        tableView.rowHeight = GameSellListCell.cellHeight
        return tableView
    }()
    
    private lazy var viewModel = GameSellListViewModel()
    private lazy var vmOutput = viewModel.transform(input: vmInput)
    private lazy var vmInput = GameSellListViewModel.Input(date: date)
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        bindUI()
        setUpRefresh()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    convenience init(date: Int) {
        self.init()
        self.date = date
    }
}

// MARK: - 设置 UI 界面
extension GameSellListViewController {
    
    private func setUpUI() {
        view.addSubview(tableView)
    }
    
    private func bindUI() {
        
        dataSource = RxTableViewSectionedReloadDataSource<GameSellListSection>(configureCell: { (ds, tb, ip, item) in
            
            let cell = tb.dequeueReusableCell(for: ip, cellType: GameSellListCell.self)
            cell.item = item
            return cell
        })
        
        vmOutput.sections
        .drive(tableView.rx.items(dataSource: dataSource))
        .disposed(by: rx.disposeBag)
    }
}

// MARK: - Refreshable
extension GameSellListViewController: Refreshable {
    
    private func setUpRefresh() {
        
        let refreshHeader = initRefreshHeader(tableView) { [weak self] in
            self?.vmInput.requestCommand.onNext(())
        }
        vmOutput
        .autoSetRefreshHeaderState(header: refreshHeader, footer: nil)
        .disposed(by: rx.disposeBag)
        refreshHeader.beginRefreshing()
    }
}
