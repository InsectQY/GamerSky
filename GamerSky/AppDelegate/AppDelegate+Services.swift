//
//  AppDelegate+Services.swift
//  SSDispatch
//
//  Created by insect_qy on 2018/9/13.
//  Copyright © 2018年 insect_qy. All rights reserved.
//

import Foundation
import Moya

extension AppDelegate {
    
    // MARK: - 初始化崩溃统计
    func initBugly() {
        
        let config = BuglyConfig()
        config.blockMonitorEnable = true
        Bugly.start(withAppId: BuglyID, config: config)
    }

    // MARK: - 初始化网络请求
    func setUpNetwork() {
        
        Network.Configuration.default.timeoutInterval = 20
        Network.Configuration.default.plugins = [NetworkLoggerPlugin(verbose: true)]
    }
}
