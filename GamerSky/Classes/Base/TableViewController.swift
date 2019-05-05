//
//  BaseTableViewController.swift
//  QYNews
//
//  Created by Insect on 2019/1/25.
//  Copyright © 2019 Insect. All rights reserved.
//

import UIKit

class TableViewController: ViewController {

    // MARK: - Lazyload
    lazy var tableView: TableView = {

        let tableView = TableView(frame: CGRect(), style: .plain)
        return tableView
    }()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    override func makeUI() {
        super.makeUI()

        view.addSubview(tableView)
    }

    override func bindViewModel() {
        super.bindViewModel()

    }

    func beginHeaderRefresh() {

        tableView.refreshHeader.beginRefreshing { [weak self] in
            self?.setUpEmptyDataSet()
        }
    }

    // MARK: - 设置 DZNEmptyDataSet
    func setUpEmptyDataSet() {
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
    }
}

// MARK: - RefreshComponent
extension TableViewController: RefreshComponentable {

    var header: ControlEvent<Void> {

        return tableView.refreshHeader.rx.refreshing
    }

    var footer: ControlEvent<Void> {

        return tableView.refreshFooter.rx.refreshing
    }
}

// MARK: - BindRefreshState
extension TableViewController: BindRefreshStateable {

    func bindHeaderRefresh(with state: Observable<Bool>) {

        state
        .bind(to: tableView.refreshHeader.rx.isRefreshing)
        .disposed(by: rx.disposeBag)
    }

    func bindFooterRefresh(with state: Observable<RxMJRefreshFooterState>) {

        state
        .bind(to: tableView.refreshFooter.rx.refreshFooterState)
        .disposed(by: rx.disposeBag)
    }
}

// MARK: - Reactive-extension
extension Reactive where Base: TableViewController {

    var reloadEmptyDataSet: Binder<Void> {

        return Binder(base) { vc, _ in
            vc.tableView.reloadEmptyDataSet()
        }
    }

    var beginHeaderRefresh: Binder<Void> {

        return Binder(base) { vc, _ in
            vc.beginHeaderRefresh()
        }
    }
}
