//
//  NewsViewController.swift
//  GamerSky
//
//  Created by engic on 2018/4/2.
//  Copyright © 2018年 engic. All rights reserved.
//

import UIKit
import SwiftNotificationCenter

class NewsViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        loadAllChannel()
    }
    
    override func repeatClickTabBar() {
        print("\(self)")
    }

}

extension NewsViewController {
    
    private func setUpUI() {
        
        
    }
}

// MARK: - 网络请求
extension NewsViewController {
    
    // MARK: - 加载频道数据
    private func loadAllChannel() {
       
        ApiProvider.request(Api.allChannel, objectModel: BaseModel<[Channel]>.self, success: {
            print("成功----\($0)")
        }) {
            print("失败----\($0)")
        }
    }
}
