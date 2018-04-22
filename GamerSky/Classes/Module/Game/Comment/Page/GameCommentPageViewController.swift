//
//  GamePageViewController.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/22.
//Copyright © 2018年 engic. All rights reserved.
//

import UIKit

class GameCommentPageViewController: UIViewController {
    
    // MARK: - LazyLoad
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }
}

// MARK: - 设置 UI 界面
extension GameCommentPageViewController {
    
    private func setUpUI() {
        
        view.backgroundColor = .white
    }
}
