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
    public var commentType: GameCommentType = .hot
    /// 页码
    private var page = 1
    // MARK: - LazyLoad
    private lazy var commets = [GameComment]()

    private lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.contentInset = UIEdgeInsetsMake(0, 0, KBottomH + kTopH, 0)
        tableView.separatorStyle = .none
        tableView.register(cellType: GameCommentCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableViewAutomaticDimension
        return tableView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        setUpRefresh()
    }
}

// MARK: - 设置 UI 界面
extension GameCommentListViewController {
    
    private func setUpUI() {
        
        view.addSubview(tableView)
    }
}

extension GameCommentListViewController {
    
    private func setUpRefresh() {
        
        tableView.qy_header = QYRefreshHeader(refreshingBlock: { [weak self] in
            
            guard let strongSelf = self else {return}
            
            strongSelf.page = 1
            strongSelf.tableView.qy_footer.endRefreshing()
            ApiProvider.request(.gameReviewList(strongSelf.page, strongSelf.commentType), objectModel: BaseModel<[GameComment]>.self, success: {
                
                strongSelf.commets = $0.result
                strongSelf.tableView.reloadData()
                strongSelf.tableView.qy_header.endRefreshing()
            }, failure: { _ in
                strongSelf.tableView.qy_header.endRefreshing()
            })
        })
        
        tableView.qy_footer = QYRefreshFooter(refreshingBlock: { [weak self] in
            
            guard let strongSelf = self else {return}
            
            strongSelf.page += 1
            strongSelf.tableView.qy_header.endRefreshing()
            ApiProvider.request(.gameReviewList(strongSelf.page, strongSelf.commentType), objectModel: BaseModel<[GameComment]>.self, success: {
                
                strongSelf.commets += $0.result
                strongSelf.tableView.reloadData()
                strongSelf.tableView.qy_footer.endRefreshing()
            }, failure: { _ in
                strongSelf.tableView.qy_footer.endRefreshing()
            })
        })
        
        tableView.qy_header.beginRefreshing()
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
