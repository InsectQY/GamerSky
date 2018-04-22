//
//  GameListViewController.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/22.
//Copyright © 2018年 engic. All rights reserved.
//

import UIKit

class GameCommentListViewController: UIViewController {
    
    // MARK: - LazyLoad
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }
}

// MARK: - 设置 UI 界面
extension GameCommentListViewController {
    
    private func setUpUI() {
        
        view.backgroundColor = .white
    }
}
