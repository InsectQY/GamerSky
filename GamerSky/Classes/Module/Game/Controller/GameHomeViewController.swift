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

    // MARK: - Lazyload
    
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
        tableView.register(cellType: GameHomeHotContentCell.self)
        tableView.register(cellType: GameHomeWaitSellContentCell.self)
        tableView.register(cellType: GameHomeExpectedContentCell.self)
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
        
        let headerView = GameHomeHeaderView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: GameHomeHeaderView.headerHeight))
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
        
        tableView.mj_header = QYRefreshHeader(refreshingBlock: { [weak self] in
            
            guard let strongSelf = self else {return}
            
            let group = DispatchGroup()
            
            // sectionHeader 数据
            let data = try! Data(contentsOf: Bundle.main.url(forResource: "GameHomeSectionData.plist", withExtension: nil)!)
            strongSelf.sectionData = try! PropertyListDecoder().decode([GameHomeSection].self, from: data)

            // 新游推荐
            group.enter()
            ApiProvider.request(.gameSpecialDetail(1, "13"), objectModel: BaseModel<[GameInfo]>.self, success: {
                
                strongSelf.gameSpecialDetail = $0.result
                group.leave()
            }, failure: { _ in
                strongSelf.tableView.mj_header.endRefreshing()
            })
            
            // 最近大家都在玩
            group.enter()
            ApiProvider.request(.gameHomePage(1, GameType.hot), objectModel: BaseModel<[GameInfo]>.self, success: {
                
                strongSelf.hotGame = $0.result
                group.leave()
            }, failure: {_ in
                strongSelf.tableView.mj_header.endRefreshing()
            })
            
            // 即将发售
            group.enter()
            ApiProvider.request(.gameHomePage(1, GameType.waitSell), objectModel: BaseModel<[GameInfo]>.self, success: {
                
                strongSelf.waitSellGame = $0.result
                group.leave()
            }, failure: { _ in
                
                strongSelf.tableView.mj_header.endRefreshing()
            })
            
            // 最期待游戏
            group.enter()
            ApiProvider.request(.gameHomePage(1, GameType.expected), objectModel: BaseModel<[GameInfo]>.self, success: {
                
                strongSelf.expectedGame = $0.result
                group.leave()
            }, failure: { _ in
                strongSelf.tableView.mj_header.endRefreshing()
            })
            
            // 找游戏
            group.enter()
            ApiProvider.request(.gameTags, objectModel: BaseModel<[GameTag]>.self, success: {
                
                strongSelf.gameTags = $0.result
                group.leave()
            }) { _ in
                strongSelf.tableView.mj_header.endRefreshing()
            }
            
            // 特色专题
            group.enter()
            ApiProvider.request(.gameSpecialList(1), objectModel: BaseModel<[GameSpecialList]>.self, success: {
                
                strongSelf.gameColumn = $0.result
                group.leave()
            }) { _ in
                strongSelf.tableView.mj_header.endRefreshing()
            }
            
            // 高分榜
            group.enter()
            ApiProvider.request(.gameRankingList(1, GameRanking.score, "0", "all"), objectModel: BaseModel<[GameInfo]>.self, success: {
                
                strongSelf.rankingGame = [Array($0.result.prefix(5))]
                // 热门榜
                ApiProvider.request(.gameRankingList(1, GameRanking.hot, "0", "all"), objectModel: BaseModel<[GameInfo]>.self, success: {
                    
                    strongSelf.rankingGame += [Array($0.result.prefix(5))]
                    // 高分 FPS
                    ApiProvider.request(.gameRankingList(1, GameRanking.score, "20066", "all"), objectModel: BaseModel<[GameInfo]>.self, success: {
                        
                        strongSelf.rankingGame += [Array($0.result.prefix(5))]
                        // 高分 ACT
                        ApiProvider.request(.gameRankingList(1, GameRanking.score, "20042", "all"), objectModel: BaseModel<[GameInfo]>.self, success: {
                            
                            strongSelf.rankingGame += [Array($0.result.prefix(5))]
                            group.leave()
                        }, failure: { _ in
                            strongSelf.tableView.mj_header.endRefreshing()
                        })
                    }, failure: { _ in
                        strongSelf.tableView.mj_header.endRefreshing()
                    })
                }, failure: { _ in
                    strongSelf.tableView.mj_header.endRefreshing()
                })
            }, failure: { _ in
                strongSelf.tableView.mj_header.endRefreshing()
            })
            
            group.notify(queue: DispatchQueue.main, execute: {
                
                strongSelf.setUpTableHeader()
                strongSelf.tableView.reloadData()
                strongSelf.tableView.mj_header.endRefreshing()
            })
        })
        
        tableView.mj_header.beginRefreshing()
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
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GameHomeRecommendContentCell.self)
            cell.gameSpecialDetail = gameSpecialDetail
            return cell
        }else if indexPath.section == 1 {
            
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GameHomeHotContentCell.self)
            cell.sectionHeader = sectionData[indexPath.section]
            cell.hotGame = hotGame
            return cell
        }else if indexPath.section == 2 {
            
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GameHomeColumnContentCell.self)
            cell.columnGame = gameColumn
            return cell
        }else if indexPath.section == 3 {
            
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GameHomeWaitSellContentCell.self)
            cell.sectionHeader = sectionData[indexPath.section]
            cell.waitSellGame = waitSellGame
            return cell
        }else if indexPath.section == 4 {
            
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GameHomeRankingContentCell.self)
            cell.rankingGame = rankingGame
            return cell
        }else if indexPath.section == 5 {
            
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GameHomeExpectedContentCell.self)
            cell.sectionHeader = sectionData[indexPath.section]
            cell.expectedGame = expectedGame
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionHeader = tableView.dequeueReusableHeaderFooterView(GameHomeSectionHeader.self)
        sectionHeader.sectionData = sectionData[section]
        return sectionHeader
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return GameHomeRecommendContentCell.cellHeight
        }else if indexPath.section == 1 {
            return GameHomeHotContentCell.cellHeight
        }else if indexPath.section == 2 {
            return GameHomeColumnContentCell.cellHeight
        }else if indexPath.section == 3 {
            return GameHomeWaitSellContentCell.cellHeight
        }else if indexPath.section == 4 {
            return GameHomeRankingContentCell.cellHeight
        }else if indexPath.section == 5{
            return GameHomeExpectedContentCell.cellHeight
        }else {
            return GameTagContentCell.cellHeight
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return GameHomeSectionHeader.sectionHeight
    }
}
