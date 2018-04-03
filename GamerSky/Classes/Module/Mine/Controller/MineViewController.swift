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
    
    private let mineCellID = "mineCellID"
    
    private lazy var nightModeSwitch: UISwitch = {
        
        let nightSwitch = UISwitch(frame: CGRect(x: ScreenWidth - 66, y: 4, width: 100, height: 36))
        nightSwitch.addTarget(self, action: #selector(nightModeSwitchChanged), for: .valueChanged)
        return nightSwitch
    }()
    
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

extension MineViewController {
    
    @objc private func nightModeSwitchChanged() {
        
    }
}

// MARK: - UITableViewDataSource
extension MineViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: mineCellID)
        cell.textLabel?.text = "夜间模式"
        cell.selectionStyle = .none
        cell.contentView.addSubview(nightModeSwitch)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MineViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
