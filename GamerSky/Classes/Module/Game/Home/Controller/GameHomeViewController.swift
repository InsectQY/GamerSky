//
//  GameViewController.swift
//  GamerSky
//
//  Created by QY on 2018/4/2.
//  Copyright © 2018年 QY. All rights reserved.
//

import UIKit
import SwiftNotificationCenter
import RxSwift
import NSObject_Rx
import RxDataSources

class GameHomeViewController: BaseViewController {
    
//    /// 新游推荐
//    private lazy var gameSpecialDetail = [GameInfo]()
//    /// 最近大家都在玩
//    private lazy var hotGame = [GameInfo]()
//    /// 即将发售
//    private lazy var waitSellGame = [GameInfo]()
//    /// 最期待游戏
//    private lazy var expectedGame = [GameInfo]()
//    /// 排行榜
//    private lazy var rankingGame = [[GameInfo]]()
//    /// 找游戏
//    private lazy var gameTags = [GameTag]()
//    /// 特色专题
//    private lazy var gameColumn = [GameSpecialList]()
//    /// section 数据
//    private lazy var sectionData = [GameHomeSectionModel]()
    
    private lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .grouped)
//        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(cellType: GameHomeRecommendContentCell.self)
        tableView.register(cellType: GameHomeWaitSellContentCell.self)
        tableView.register(cellType: GameHomeRankingContentCell.self)
        tableView.register(cellType: GameTagContentCell.self)
        tableView.register(cellType: GameHomeColumnContentCell.self)
        tableView.register(headerFooterViewType: GameHomeSectionHeader.self)
        tableView.contentInset = UIEdgeInsetsMake(kTopH, 0, 25, 0)
        tableView.scrollIndicatorInsets = UIEdgeInsetsMake(kTopH, 0, 25, 0)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.tableHeaderView = headerView
        return tableView
    }()
    
    private lazy var headerView: GameHomeHeaderView = {
        
        let headerView = GameHomeHeaderView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: GameHomeHeaderView.height))
        return headerView
    }()
    
    private lazy var viewModel = GameHomeViewModel()
    
    private lazy var vmOutput: GameHomeViewModel.GameHomeOutput = {
        
        let vmOutput = viewModel.transform(input: GameHomeViewModel.GameHomeInput())
        return vmOutput
    }()
    
    var dataSource : RxTableViewSectionedReloadDataSource<GameHomeSection>!

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        setUpNavi()
        setUpRefresh()
        bindUI()
    }
    
    override func repeatClickTabBar() {
        print("\(self)")
    }
}

extension GameHomeViewController {
    
    private func bindUI() {
        
        dataSource = RxTableViewSectionedReloadDataSource<GameHomeSection>(configureCell: { (ds, tableView, indexPath, item) -> UITableViewCell in
            
            let row = ds[indexPath.section]
            if indexPath.section % 2 == 1 { // 1,3,5
                
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GameHomeWaitSellContentCell.self)
//                cell.sectionType = item.sectionType
                switch indexPath.section {
                    
                case 1:
                    cell.game = row.hotGame
                case 3:
                    cell.game = row.waitSellGame
                case 5:
                    cell.game = row.expectedGame
                default:
                    break
                }
                return cell
            }
            
            if indexPath.section == 0 {
                
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GameHomeRecommendContentCell.self)
                cell.gameSpecialDetail = row.gameSpecialDetail
                return cell
            }else if indexPath.section == 2 {
                
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GameHomeColumnContentCell.self)
                cell.columnGame = row.gameColumn
                return cell
            }else if indexPath.section == 4 {
                
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GameHomeRankingContentCell.self)
                cell.rankingGame = row.rankingGame
                return cell
            }else {
                
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GameTagContentCell.self)
                cell.gameTag = row.gameTags
                return cell
            }
        })
        
        vmOutput.sections
        .drive(tableView.rx.items(dataSource: dataSource))
        .disposed(by: rx.disposeBag)
    }
}

extension GameHomeViewController: Refreshable {
    
    private func setUpRefresh() {
        
        let refreshHeader = initRefreshHeader(tableView) { [weak self] in
            self?.vmOutput.requestCommand.onNext(())
        }
        
        vmOutput.autoSetRefreshHeaderStatus(header: refreshHeader).disposed(by: rx.disposeBag)
        
        refreshHeader.beginRefreshing()
    }
}

//extension GameHomeViewController {
//    
//    private func setUpRefresh() {
//        
//        tableView.qy_header = QYRefreshHeader(refreshingBlock: { [weak self] in
//            
//            guard let `self` = self else {return}
//            
//            // sectionHeader 数据
//            let data = try! Data(contentsOf: Bundle.main.url(forResource: "GameHomeSectionData", withExtension: "plist")!)
//            self.sectionData = try! PropertyListDecoder().decode([GameHomeSectionModel].self, from: data)
//            
//            // 新游推荐
//            let symbol1 = GameApi.gameSpecialDetail(1, 13)
//            .cache
//            .request(objectModel: BaseModel<[GameInfo]>.self)
//            
//            // 最近大家都在玩
//            let symbol2 = GameApi.gameHomePage(1, .hot)
//            .cache
//            .request(objectModel: BaseModel<[GameInfo]>.self)
//            
//            // 即将发售
//            let symbol3 = GameApi.gameHomePage(1, .waitSell)
//            .cache
//            .request(objectModel: BaseModel<[GameInfo]>.self)
//            
//            // 最期待游戏
//            let symbol4 = GameApi.gameHomePage(1, .expected)
//            .cache
//            .request(objectModel: BaseModel<[GameInfo]>.self)
//            
//            // 找游戏
//            let symbol5 = GameApi.gameTags
//            .cache
//            .request(objectModel: BaseModel<[GameTag]>.self)
//            
//            // 特色专题
//            let symbol6 = GameApi.gameSpecialList(1)
//            .cache
//            .request(objectModel: BaseModel<[GameSpecialList]>.self)
//            
//            // 高分榜
//            let symbol7 = GameApi.gameRankingList(1, .fractions, 0, "all")
//            .cache
//            .request(objectModel: BaseModel<[GameInfo]>.self)
//            .map({[Array($0.result.prefix(5))]})
//            
//            // 热门榜
//            let symbol8 = GameApi.gameRankingList(1, .hot, 0, "all")
//            .cache
//            .request(objectModel: BaseModel<[GameInfo]>.self)
//            .map({[Array($0.result.prefix(5))]})
//            
//            Observable
//            .zip(symbol1, symbol2, symbol3, symbol4, symbol5, symbol6,symbol7, symbol8)
//            .subscribe(onNext: { (symbol1Data, symbol2Data, symbol3Data, symbol4Data, symbol5Data, symbol6Data,symbol7Data,symbol8Data) in
//                
//                self.gameSpecialDetail = symbol1Data.result
//                self.hotGame = symbol2Data.result
//                self.waitSellGame = symbol3Data.result
//                self.expectedGame = symbol4Data.result
//                self.gameTags = symbol5Data.result
//                self.gameColumn = symbol6Data.result
//                self.rankingGame = symbol7Data
//                self.rankingGame += symbol8Data
//                self.tableView.reloadData()
//                self.tableView.qy_header.endRefreshing()
//            }).disposed(by: self.rx.disposeBag)
//        })
//        
//        tableView.qy_header.beginRefreshing()
//    }
//}

extension GameHomeViewController {
    
    private func setUpUI() {
        
        view.addSubview(tableView)
    }
    
    // MARK: - 设置导航栏
    private func setUpNavi() {
        
        automaticallyAdjustsScrollViewInsets = false
        let leftItem = BaseLabel(frame: CGRect(x: 10, y: 0, width: 200, height: kNaviBarH))
        leftItem.font = PFM18Font
        leftItem.text = "游戏"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftItem)
    }
    
    // MARK: - setUpTableHeader
//    private func setUpTableHeader() {
//
//        tableView.tableHeaderView = headerView
//    }
}

// MARK: - UITableViewDataSource
//extension GameHomeViewController: UITableViewDataSource {
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return sectionData.count
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        if indexPath.section % 2 == 1 { // 1,3,5
//
//            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GameHomeWaitSellContentCell.self)
//            cell.sectionType = sectionData[indexPath.section].sectionType
//            switch indexPath.section {
//
//            case 1:
//                cell.game = hotGame
//            case 3:
//                cell.game = waitSellGame
//            case 5:
//                cell.game = expectedGame
//            default:
//                break
//            }
//            return cell
//        }
//
//        if indexPath.section == 0 {
//
//            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GameHomeRecommendContentCell.self)
//            cell.gameSpecialDetail = gameSpecialDetail
//            return cell
//        }else if indexPath.section == 2 {
//
//            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GameHomeColumnContentCell.self)
//            cell.columnGame = gameColumn
//            return cell
//        }else if indexPath.section == 4 {
//
//            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GameHomeRankingContentCell.self)
//            cell.rankingGame = rankingGame
//            return cell
//        }else {
//
//            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GameTagContentCell.self)
//            cell.gameTag = gameTags
//            return cell
//        }
//    }
//}

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
