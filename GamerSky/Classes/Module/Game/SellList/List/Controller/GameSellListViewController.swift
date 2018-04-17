//
//  GameSellListViewController.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/17.
//Copyright © 2018年 engic. All rights reserved.
//

import UIKit

class GameSellListViewController: UIViewController {
    
    public var date: Int = 0
    // MARK: - LazyLoad
    private lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: UIScreen.main.bounds)
        tableView.contentInset = UIEdgeInsetsMake(kTopH + 44, 0, KBottomH, 0)
        return tableView
    }()
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }
}

// MARK: - 设置 UI 界面
extension GameSellListViewController {
    
    private func setUpUI() {
        
        view.addSubview(tableView)
    }
    
    private func setUpRefresh() {
        
    }
}
