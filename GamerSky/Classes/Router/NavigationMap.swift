//
//  NavigationMap.swift
//  GamerSky
//
//  Created by QY on 2018/5/24.
//  Copyright © 2018年 QY. All rights reserved.
//

import URLNavigator

let navigator = NavigationMap.default

enum NavigationURL {
    
    /// 文章详情
    case contentDetail(Int?)
    /// 栏目详情
    case columnDetail(Bool?, Int?)
    
    static func get(_ type: NavigationURL) -> String {
        
        switch type {
        case let .contentDetail(url):
            
            if let url = url {
               return "navigator://contentDetail/\(url)"
            }
            return "navigator://contentDetail/<int:ID>"
        case let .columnDetail(isHasSubList, nodeID):
            
            if let isHasSubList = isHasSubList, let nodeID = nodeID {
                return "navigator://columnDetail/\(isHasSubList)/\(nodeID)"
            }
            return "navigator://columnDetail/<isHasSubList>/<int:nodeID>"
        }
    }
}

enum NavigationMap {
    
    static fileprivate let `default` = Navigator()
    
    static func initialize() {
        
        navigator.register(NavigationURL.get(.contentDetail(nil))) { url, values, context in
            
            guard let ID = values["ID"] as? Int else {return nil}
            return ContentDetailViewController(ID: ID)
        }
        
        navigator.register(NavigationURL.get(.columnDetail(nil, nil))) { (url, values, context) in
            
            guard let isHasSubList = values["isHasSubList"] as? String, let nodeID = values["nodeID"] as? Int else {return nil}
            let hasSubList = isHasSubList == "true" ? true : false
            return ColumnDetailViewController(isHasSubList: hasSubList, nodeID: nodeID)
        }
    }
}
