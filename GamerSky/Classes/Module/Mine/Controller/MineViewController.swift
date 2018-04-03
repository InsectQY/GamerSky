//
//  MineViewController.swift
//  GamerSky
//
//  Created by engic on 2018/4/3.
//  Copyright © 2018年 engic. All rights reserved.
//

import UIKit

class MineViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavi()
    }
}

extension MineViewController {
    
    // MARK: - 设置导航栏
    private func setUpNavi() {
        
        automaticallyAdjustsScrollViewInsets = false
        fd_prefersNavigationBarHidden = true
    }
}

// MARK: - UITableViewDataSource
extension MineViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "")
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MineViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
