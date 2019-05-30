//
//  MineViewController.swift
//  GamerSky
//
//  Created by QY on 2018/4/3.
//  Copyright © 2018年 QY. All rights reserved.
//

import UIKit

class MineViewController: ViewController<ViewModel> {

    // MARK: - IBOutlet
    @IBOutlet private weak var tableView: UITableView!
    
    private let mineCellID = "mineCellID"
    
    // MARK: - Lazyload
    private lazy var nightModeSwitch: UISwitch = {
        
        let nightSwitch = UISwitch()
        nightSwitch.addTarget(self, action: #selector(nightModeSwitchChanged), for: .valueChanged)
        nightSwitch.backgroundColor = .clear
        nightSwitch.frame = CGRect(x: ScreenWidth - 66, y: 8, width: 44, height: 44)
        return nightSwitch
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavi()
        setUpTheme()
        loadLocalPreference()
    }
}

extension MineViewController {
    
    // MARK: - 设置导航栏
    private func setUpNavi() {
        
        fd_prefersNavigationBarHidden = true
    }
    
    // MARK: - 设置主题
    private func setUpTheme() {
        
        qy_themeBackgroundColor = "colors.whiteSmoke"
    }
    
    // MARK: - 加载本地偏好设置
    private func loadLocalPreference() {
        
        guard let preference = QYUserDefaults.getUserPreference() else {return}
        AppTheme.switchTo(preference.currentTheme)
        nightModeSwitch.isOn = preference.currentTheme == .night
    }
}

extension MineViewController {
    
    @objc private func nightModeSwitchChanged() {
        
        AppTheme.switchNight(nightModeSwitch.isOn)
        // 先不传 ID 后续有登陆功能再加上
        var preference = Preference(currentTheme: .day, isNoneImage: false)
        // 把本地其他偏好属性取出
        if let local = QYUserDefaults.getUserPreference() {
            preference = local
        }
        // 修改主题
        preference.currentTheme = AppTheme.current
        // 保存
        QYUserDefaults.saveUserPreference(preference: preference)
    }
}

// MARK: - UITableViewDataSource
extension MineViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = TableViewCell(style: .value1, reuseIdentifier: mineCellID)
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
