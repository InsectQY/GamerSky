//
//  GameViewController.swift
//  GamerSky
//
//  Created by QY on 2018/4/2.
//  Copyright © 2018年 QY. All rights reserved.
//

import UIKit
import RxDataSources

class GameHomeViewController: ViewController {
    
    private lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .grouped)
        tableView.delegate = self
        tableView.register(cellType: GameHomeRecommendContentCell.self)
        tableView.register(cellType: GameHomeWaitSellContentCell.self)
        tableView.register(cellType: GameHomeRankingContentCell.self)
        tableView.register(cellType: GameTagContentCell.self)
        tableView.register(cellType: GameHomeColumnContentCell.self)
        tableView.register(headerFooterViewType: GameHomeSectionHeader.self)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.tableHeaderView = headerView
        tableView.qy_header = QYRefreshHeader()
        return tableView
    }()
    
    private lazy var headerView: GameHomeHeaderView = {
        
        let headerView = GameHomeHeaderView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: GameHomeHeaderView.height))
        return headerView
    }()
    
    private lazy var viewModel = GameHomeViewModel()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavi()
    }
    
    override func repeatClickTabBar() {
        print("\(self)")
    }
    
    override func makeUI() {
        super.makeUI()
        view.addSubview(tableView)
        tableView.qy_header.beginRefreshing()
    }
    
    override func bindViewModel() {
        
        let input = GameHomeViewModel.GameHomeInput(headerRefresh: tableView.qy_header.rx.refreshing.asDriver())
        let output = viewModel.transform(input: input)
        
        let dataSource = RxTableViewSectionedReloadDataSource<GameHomeSection>(configureCell: { (ds, tableView, indexPath, item) -> UITableViewCell in
            
            switch ds[indexPath] {
            case let .specialDetailItem(row):
                
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GameHomeRecommendContentCell.self)
                cell.gameSpecialDetail = row
                return cell
            case let .hotItem(row, sectionModels):
                
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GameHomeWaitSellContentCell.self)
                cell.sectionType = sectionModels[indexPath.section].sectionType
                cell.game = row
                return cell
            case let .specialListItem(row):
                
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GameHomeColumnContentCell.self)
                cell.columnGame = row
                return cell
            case let .waitSellItem(row,sectionModels):
                
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GameHomeWaitSellContentCell.self)
                cell.sectionType = sectionModels[indexPath.section].sectionType
                cell.game = row
                return cell
            case let .rankingItem(row):
                
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GameHomeRankingContentCell.self)
                cell.rankingGame = row
                return cell
            case let .expectedItem(row, sectionModels):
                
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GameHomeWaitSellContentCell.self)
                cell.sectionType = sectionModels[indexPath.section].sectionType
                cell.game = row
                return cell
            case let .tagItem(row):
                
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GameTagContentCell.self)
                cell.gameTag = row
                return cell
            }
        })
        
        output.sections
        .drive(tableView.rx.items(dataSource: dataSource))
        .disposed(by: rx.disposeBag)
        
        // 刷新状态
        output.endHeaderRefresh
        .drive(tableView.qy_header.rx.isRefreshing)
        .disposed(by: rx.disposeBag)
    }
}

extension GameHomeViewController {

    // MARK: - 设置导航栏
    private func setUpNavi() {
        
        let leftItem = Label(frame: CGRect(x: 10, y: 0, width: 200, height: kNaviBarH))
        leftItem.font = PFM18Font
        leftItem.text = "游戏"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftItem)
    }
}

// MARK: - UITableViewDelegate
extension GameHomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionHeader = tableView
            .dequeueReusableHeaderFooterView(GameHomeSectionHeader.self)
//        sectionHeader.sectionData = sectionData[section]
        return sectionHeader
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let cellHeight = [GameHomeRecommendContentCell.cellHeight, GameHomeWaitSellContentCell.hotHeight, GameHomeColumnContentCell.cellHeight, GameHomeWaitSellContentCell.waitSellingHeight, GameHomeRankingContentCell.cellHeight, GameHomeWaitSellContentCell.hotHeight,GameTagContentCell.cellHeight]
        return cellHeight[indexPath.section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return GameHomeSectionHeader.sectionHeight
    }
}
