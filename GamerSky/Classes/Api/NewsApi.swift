//
//  NewsApi.swift
//  GamerSky
//
//  Created by QY on 2018/5/19.
//  Copyright © 2018年 QY. All rights reserved.
//

import Moya
import Cache

enum NewsApi {
    
    /// 新闻频道
    case allChannel
    /// 频道列表(参数依次是: page, 频道 ID)
    case allChannelList(Int, Int)
}

extension NewsApi: TargetType {
    
    var baseURL: URL {
        return URL(string: AppHostIP)!
    }
    
    var path: String {
        
        switch self {
        case .allChannel:
            return "v2/allchannel"
        case .allChannelList:
            return "v2/AllChannelList"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .post
        }
    }
    
    var task: Task {
        
        var parmeters: [String: Any] = ["device_id": deviceID,
                                        "os": "iOS",
                                        "osVersion": osVersion,
                                        "app": "GSApp",
                                        "appVersion": "3.7.4"]
        switch self {
            
        case .allChannel:
            
            parmeters["request"] = ["type" : "0"]
        case let .allChannelList(page, nodeID):
            
            parmeters["request"] = ["parentNodeId" : "news",
                                    "nodeIds" : "\(nodeID)",
                "pageIndex": page,
                "elementsCountPerPage" : 20]
        }
        
        return .requestParameters(parameters: parmeters, encoding: JSONEncoding.default)
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
}
