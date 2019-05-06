//
//  GameListViewController.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/22.
//Copyright © 2018年 QY. All rights reserved.
//

import UIKit
import JXCategoryView

class GameCommentListViewController: TableViewController {
    
    /// 评价类型
    private var commentType: GameCommentType = .hot
    // MARK: - LazyLoad
    private lazy var viewModel = GameCommentListViewModel(input: self)
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - convenience
    init(commentType: GameCommentType) {
        super.init(style: .grouped)
        self.commentType = commentType
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func makeUI() {
        super.makeUI()

        tableView.register(cellType: GameCommentCell.self)
        tableView.refreshHeader = RefreshHeader()
        tableView.refreshFooter = RefreshFooter()
        beginHeaderRefresh()
    }

    override func bindViewModel() {
        super.bindViewModel()

        let input = GameCommentListViewModel.Input(commentType: commentType)
        let output = viewModel.transform(input: input)
        
        output.items.drive(tableView.rx.items(cellIdentifier: GameCommentCell.ID, cellType: GameCommentCell.self)) { tableView, item, cell in
            cell.comment = item
        }
        .disposed(by: rx.disposeBag)
    }
}
