//
//  GameListViewController.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/22.
//Copyright © 2018年 QY. All rights reserved.
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
        tableView.separatorStyle = .none
        tableView.register(cellType: GameCommentCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = 10
        tableView.sectionFooterHeight = 10
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
            
            guard let `self` = self else {return}
            
            self.page = 1
            self.tableView.qy_footer.endRefreshing()
            GameApi.gameReviewList(self.page, self.commentType)
            .cache
            .request()
            .mapObject(BaseModel<[GameComment]>.self)
            .subscribe(onNext: {
                
                self.commets = $0.result
                self.tableView.reloadData()
                self.tableView.qy_header.endRefreshing()
            }, onError: { _ in
                self.tableView.qy_header.endRefreshing()
            })
            .disposed(by: self.rx.disposeBag)
        })
        
        tableView.qy_footer = QYRefreshFooter(refreshingBlock: { [weak self] in
            
            guard let `self` = self else {return}
            
            self.page += 1
            self.tableView.qy_header.endRefreshing()
            
            GameApi.gameReviewList(self.page, self.commentType)
            .cache
            .request()
            .mapObject(BaseModel<[GameComment]>.self)
            .subscribe(onNext: {
                
                self.commets += $0.result
                self.tableView.reloadData()
                self.tableView.qy_footer.endRefreshing()
            }, onError: { _ in
                self.tableView.qy_header.endRefreshing()
            })
            .disposed(by: self.rx.disposeBag)
        })
        
        tableView.qy_header.beginRefreshing()
    }
}

// MARK: - UITableViewDataSource
extension GameCommentListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return commets.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GameCommentCell.self)
        cell.comment = commets[indexPath.section]
        return cell
    }
}

// MARK: - UITableViewDelegate
extension GameCommentListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
