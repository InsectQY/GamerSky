//
//  GameViewController.swift
//  GamerSky
//
//  Created by engic on 2018/4/2.
//  Copyright © 2018年 engic. All rights reserved.
//

import UIKit
import SwiftNotificationCenter

class GameHomeViewController: BaseViewController {
    
    /// 新游推荐
    private lazy var gameSpecialDetail = [GameInfo]()
    /// 最近大家都在玩
    private lazy var hotGame = [GameInfo]()
    /// 即将发售
    private lazy var waitSellGame = [GameInfo]()
    /// 最期待游戏
    private lazy var expectedGame = [GameInfo]()
    /// 排行榜
    private lazy var rankingGame = [[GameInfo]]()
    /// 找游戏
    private lazy var gameTags = [GameTag]()
    /// 特色专题
    private lazy var gameColumn = [GameSpecialList]()
    /// section 数据
    private lazy var sectionData = [GameHomeSection]()
    
    private lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(cellType: GameHomeRecommendContentCell.self)
        tableView.register(cellType: GameHomeWaitSellContentCell.self)
        tableView.register(cellType: GameHomeRankingContentCell.self)
        tableView.register(cellType: GameTagContentCell.self)
        tableView.register(cellType: GameHomeColumnContentCell.self)
        tableView.register(headerFooterViewType: GameHomeSectionHeader.self)
        tableView.contentInset = UIEdgeInsetsMake(kTopH, 0, 0, 0)
        tableView.scrollIndicatorInsets = UIEdgeInsetsMake(kTopH, 0, 0, 0)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private lazy var headerView: GameHomeHeaderView = {
        
        let headerView = GameHomeHeaderView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: GameHomeHeaderView.height))
        return headerView
    }()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        setUpNavi()
        setUpRefresh()
    }
    
    override func repeatClickTabBar() {
        print("\(self)")
    }
}

extension GameHomeViewController {
    
    private func setUpRefresh() {
        
        tableView.qy_header = QYRefreshHeader(refreshingBlock: { [weak self] in
            
            guard let `self` = self else {return}
            
            // sectionHeader 数据
            let data = try! Data(contentsOf: Bundle.main.url(forResource: "GameHomeSectionData", withExtension: "plist")!)
            self.sectionData = try! PropertyListDecoder().decode([GameHomeSection].self, from: data)

            let group = DispatchGroup()
            
            // 新游推荐
            group.enter()
            ApiProvider.request(.gameSpecialDetail(1, 13), objectModel: BaseModel<[GameInfo]>.self, success: {
                
                self.gameSpecialDetail = $0.result
                group.leave()
            }, failure: { _ in
                self.tableView.qy_header.endRefreshing()
                group.leave()
            })
            
            // 最近大家都在玩
            group.enter()
            ApiProvider.request(.gameHomePage(1, .hot), objectModel: BaseModel<[GameInfo]>.self, success: {
                
                self.hotGame = $0.result
                group.leave()
            }, failure: {_ in
                self.tableView.qy_header.endRefreshing()
                group.leave()
            })
            
            // 即将发售
            group.enter()
            ApiProvider.request(.gameHomePage(1, .waitSell), objectModel: BaseModel<[GameInfo]>.self, success: {
                
                self.waitSellGame = $0.result
                group.leave()
            }, failure: { _ in
                
                self.tableView.qy_header.endRefreshing()
                group.leave()
            })
            
            // 最期待游戏
            group.enter()
            ApiProvider.request(.gameHomePage(1, .expected), objectModel: BaseModel<[GameInfo]>.self, success: {
                
                self.expectedGame = $0.result
                group.leave()
            }, failure: { _ in
                self.tableView.qy_header.endRefreshing()
                group.leave()
            })
            
            // 找游戏
            group.enter()
            ApiProvider.request(.gameTags, objectModel: BaseModel<[GameTag]>.self, success: {
                
                self.gameTags = $0.result
                group.leave()
            }) { _ in
                self.tableView.qy_header.endRefreshing()
                group.leave()
            }
            
            // 特色专题
            group.enter()
            ApiProvider.request(.gameSpecialList(1), objectModel: BaseModel<[GameSpecialList]>.self, success: {
                
                self.gameColumn = $0.result
                group.leave()
            }) { _ in
                self.tableView.qy_header.endRefreshing()
                group.leave()
            }
            
            // 高分榜
            group.enter()
            ApiProvider.request(.gameRankingList(1, .fractions, 0, "all"), objectModel: BaseModel<[GameInfo]>.self, success: {
                
                self.rankingGame = [Array($0.result.prefix(5))]
                // 热门榜
                ApiProvider.request(.gameRankingList(1, .hot, 0, "all"), objectModel: BaseModel<[GameInfo]>.self, success: {
                    
                    self.rankingGame += [Array($0.result.prefix(5))]
                    group.leave()
                }, failure: { _ in
                    self.tableView.qy_header.endRefreshing()
                })
            }, failure: { _ in
                self.tableView.qy_header.endRefreshing()
            })
            
            group.notify(queue: DispatchQueue.main, execute: {
                
                self.setUpTableHeader()
                self.tableView.reloadData()
                self.tableView.qy_header.endRefreshing()
            })
        })
        
        tableView.qy_header.beginRefreshing()
    }
}

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
    private func setUpTableHeader() {
        
        tableView.tableHeaderView = headerView
    }
}

// MARK: - UITableViewDataSource
extension GameHomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section % 2 == 1 { // 1,3,5
            
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GameHomeWaitSellContentCell.self)
            cell.sectionType = sectionData[indexPath.section].sectionType
            switch indexPath.section {
                
            case 1:
                cell.game = hotGame
            case 3:
                cell.game = waitSellGame
            case 5:
                cell.game = expectedGame
            default:
                break
            }
            return cell
        }
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GameHomeRecommendContentCell.self)
            cell.gameSpecialDetail = gameSpecialDetail
            return cell
        }else if indexPath.section == 2 {
            
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GameHomeColumnContentCell.self)
            cell.columnGame = gameColumn
            return cell
        }else if indexPath.section == 4 {
            
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GameHomeRankingContentCell.self)
            cell.rankingGame = rankingGame
            return cell
        }else {
            
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GameTagContentCell.self)
            cell.gameTag = gameTags
            return cell
        }
    }
}

// MARK: - UITableViewDelegate
extension GameHomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionHeader = tableView.dequeueReusableHeaderFooterView(GameHomeSectionHeader.self)
        sectionHeader.sectionData = sectionData[section]
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
