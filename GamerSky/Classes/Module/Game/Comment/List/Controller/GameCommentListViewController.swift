//
//  GameListViewController.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/22.
//Copyright © 2018年 QY. All rights reserved.
//

import UIKit
import JXCategoryView

class GameCommentListViewController: ViewController {
    
    /// 评价类型
    private var commentType: GameCommentType = .hot
    /// 页码
    private var page = 1
    // MARK: - LazyLoad
    private lazy var commets = [GameComment]()

    private lazy var tableView: TableView = {
        
        let tableView = TableView(frame: view.bounds, style: .grouped)
        tableView.register(cellType: GameCommentCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.sectionHeaderHeight = 10
        tableView.sectionFooterHeight = 10
        return tableView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpRefresh()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // MARK: - convenience
    convenience init(commentType: GameCommentType) {
        self.init()
        self.commentType = commentType
    }
    
    override func makeUI() {
        super.makeUI()
        view.addSubview(tableView)
    }
}

extension GameCommentListViewController {
    
    private func setUpRefresh() {
        
        tableView.refreshHeader = RefreshHeader(refreshingBlock: { [weak self] in
            
            guard let `self` = self else {return}
            
            self.page = 1
            self.tableView.refreshFooter.endRefreshing()
            GameApi.gameReviewList(self.page, self.commentType)
            .cache
            .request()
            .mapObject([GameComment].self)
            .subscribe(onNext: {
                
                self.commets = $0
                self.tableView.reloadData()
                self.tableView.refreshHeader.endRefreshing()
            }, onError: { _ in
                self.tableView.refreshHeader.endRefreshing()
            })
            .disposed(by: self.rx.disposeBag)
        })
        
        tableView.refreshFooter = RefreshFooter(refreshingBlock: { [weak self] in
            
            guard let `self` = self else {return}
            
            self.page += 1
            self.tableView.refreshHeader.endRefreshing()
            
            GameApi.gameReviewList(self.page, self.commentType)
            .cache
            .request()
            .mapObject([GameComment].self)
            .subscribe(onNext: {
                
                self.commets += $0
                self.tableView.reloadData()
                self.tableView.refreshFooter.endRefreshing()
            }, onError: { _ in
                self.tableView.refreshHeader.endRefreshing()
            })
            .disposed(by: self.rx.disposeBag)
        })
        
        tableView.refreshHeader.beginRefreshing()
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
