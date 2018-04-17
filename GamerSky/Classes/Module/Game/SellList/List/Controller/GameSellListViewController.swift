//
//  GameSellListViewController.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/17.
//Copyright © 2018年 engic. All rights reserved.
//

import UIKit

class GameSellListViewController: UIViewController {
    
    public var date: String = ""
    // MARK: - LazyLoad
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }
}

// MARK: - 设置 UI 界面
extension GameSellListViewController {
    
    private func setUpUI() {
        
        view.backgroundColor = .white
    }
}
