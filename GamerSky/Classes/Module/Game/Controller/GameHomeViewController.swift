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
    public lazy var gameSpecialDetail = [GameSpecialDetail]()
    
    private lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(cellType: GameHomeRecommendContentCell.self)
        tableView.register(headerFooterViewType: GameHomeSectionHeader.self)
        tableView.rowHeight = GameHomeRecommendContentCell.cellHeight
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
            
            // 新游推荐
            ApiProvider.request(Api.gameSpecialDetail(1, "13"), objectModel: BaseModel<[GameSpecialDetail]>.self, success: {
                
                print($0)
                strongSelf.gameSpecialDetail = $0.result
                strongSelf.tableView.reloadData()
                strongSelf.tableView.mj_header.endRefreshing()
            }, failure: {
                strongSelf.tableView.mj_header.endRefreshing()
                print($0)
            })
            
            // 最近大家都在玩
            
        })
        
        tableView.mj_header.beginRefreshing()
    }
}

extension GameHomeViewController {
    
    private func setUpUI() {
        view.addSubview(tableView)
        setUpTableHeader()
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
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GameHomeRecommendContentCell.self)
        cell.gameSpecialDetail = gameSpecialDetail
        return cell
    }
}

// MARK: - UITableViewDelegate
extension GameHomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionHeader = tableView.dequeueReusableHeaderFooterView(GameHomeSectionHeader.self)
        return sectionHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return GameHomeSectionHeader.sectionHeight
    }
}
