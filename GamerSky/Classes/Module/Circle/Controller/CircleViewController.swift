//
//  CircleViewController.swift
//  GamerSky
//
//  Created by QY on 2018/4/2.
//  Copyright © 2018年 QY. All rights reserved.
//

import UIKit
import SwiftNotificationCenter

class CircleViewController: BaseViewController {

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }
    
    override func repeatClickTabBar() {
        print("\(self)")
    }
}

extension CircleViewController {
    
    private func setUpUI() {
        
    }
}
