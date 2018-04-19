//
//  GameRankingListViewController.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/19.
//Copyright © 2018年 engic. All rights reserved.
//

import UIKit

class GameRankingListViewController: UIViewController {
    
    /// 游戏种类 ID
    public var gameClass = 0
    /// 年代
    public var annualClass = "all"
    /// 排名方式
    public var rankingType = GameRankingType.fractions

    // MARK: - LazyLoad
    private lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }
}

// MARK: - 设置 UI 界面
extension GameRankingListViewController {
    
    private func setUpUI() {
        
        view.backgroundColor = .white
    }
}

// MARK: - UITableViewDataSource
extension GameRankingListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GameRankingListCell.self)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension GameRankingListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
