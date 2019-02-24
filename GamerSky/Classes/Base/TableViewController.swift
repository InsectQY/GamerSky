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
            self?.tableView.emptyDataSetSource = self
            self?.tableView.emptyDataSetDelegate = self
        }
    }
}

// MARK: - Reactive-extension
extension Reactive where Base: TableViewController {

    var reloadEmptyDataSet: Binder<Bool> {

        return Binder(base) { vc, _ in
            vc.tableView.reloadEmptyDataSet()
        }
    }
}
