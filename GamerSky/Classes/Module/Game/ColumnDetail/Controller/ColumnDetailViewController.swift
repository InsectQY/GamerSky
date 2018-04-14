//
//  ColumnDetailViewController.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/14.
//Copyright © 2018年 engic. All rights reserved.
//

import UIKit

class ColumnDetailViewController: UIViewController {
    
    // MARK: - LazyLoad
    private lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .grouped)
        return tableView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }
}

// MARK: - 设置 UI 界面
extension ColumnDetailViewController {
    
    private func setUpUI() {
        
        view.backgroundColor = .white
    }
}
