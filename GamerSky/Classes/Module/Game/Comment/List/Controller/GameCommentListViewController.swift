//
//  GameListViewController.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/22.
//Copyright © 2018年 engic. All rights reserved.
//

import UIKit

class GameCommentListViewController: BaseViewController {
    
    /// 评价类型
    public var commentType : GameCommentType = .hot
    // MARK: - LazyLoad
    private lazy var commets = [GameComment]()
    private lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.contentInset = UIEdgeInsetsMake(0, 0, KBottomH + kTopH, 0)
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 100
        tableView.register(cellType: GameCommentCell.self)
        tableView.rowHeight = UITableViewAutomaticDimension
        return tableView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }
}

// MARK: - 设置 UI 界面
extension GameCommentListViewController {
    
    private func setUpUI() {
        
        view.addSubview(tableView)
    }
}

// MARK: - UITableViewDataSource
extension GameCommentListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GameCommentCell.self)
        cell.comment = commets[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate
extension GameCommentListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
