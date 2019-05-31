//
//  GameRankingListViewController.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/19.
//Copyright © 2018年 QY. All rights reserved.
//

import UIKit
import JXCategoryView

class GameRankingListViewController: TableViewController<GameRankingListViewModel> {
    
    /// 游戏种类 ID
    private var gameClassID = 0
    /// 年代
    private var annualClass = "all"
    /// 排名方式
    private var rankingType: GameRankingType = .fractions

    // MARK: - LazyLoad
    private lazy var rankingData = [GameSpecialDetail]()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(gameClassID: Int, rankingType: GameRankingType) {
        super.init(style: .plain)

        self.gameClassID = gameClassID
        self.rankingType = rankingType
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func makeUI() {
        super.makeUI()

        tableView.register(cellType: GameColumnDetailCell.self)
        tableView.refreshHeader = RefreshHeader()
        tableView.refreshFooter = RefreshFooter()
        beginHeaderRefresh()
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        let input = GameRankingListViewModel.Input(gameClassID: gameClassID, annualClass: annualClass)
        let output = viewModel.transform(input: input)

        output.items.drive(tableView.rx.items) { (tableView, row, item) in
            
            let cell = tableView.dequeueReusableCell(for: IndexPath(row: row, section: 0), cellType: GameColumnDetailCell.self)
            cell.descLabelBottomConstraint.constant = 0
            cell.tag = row
            cell.specitial = item
            return cell
        }
        .disposed(by: rx.disposeBag)
    }
}
