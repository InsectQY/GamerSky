//
//  GameDetailViewController.swift
//  GamerSky
//
//  Created by insect_qy on 2018/7/13.
//  Copyright © 2018年 QY. All rights reserved.
//

import UIKit

class GameDetailViewController: BaseViewController {

    private var contentID = 0
    
    private lazy var headerView: GameDetailHeaderView = {
        
        let headerView = GameDetailHeaderView.loadFromNib()
        headerView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: GameDetailHeaderView.height)
        return headerView
    }()
    
    private lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .grouped)
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.tableHeaderView = headerView
        return tableView
    }()
    
    convenience init(contentID: Int) {
        
        self.init()
        self.contentID = contentID
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        loadData()
    }
}

// MARK: - setUpUI
extension GameDetailViewController {
    
    private func setUpUI() {
        view.addSubview(tableView)
    }
}

extension GameDetailViewController {
    
    private func loadData() {
        
        GameApi.gameDetail(contentID)
        .cache
        .request()
        .mapObject(GameDetail.self)
        .subscribe(onNext: {
            
            self.headerView.detail = $0
        }, onError: { (error) in
            
        }).disposed(by: rx.disposeBag)
    }
}

// MARK: - UITableViewDataSource
extension GameDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension GameDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
