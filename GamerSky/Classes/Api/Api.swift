//
//  Api.swift
//  GamerSky
//
//  Created by engic on 2018/4/2.
//  Copyright © 2018年 engic. All rights reserved.
//

import UIKit
import Moya

let timeoutClosure = {(endpoint: Endpoint, closure: MoyaProvider<Api>.RequestResultClosure) -> Void in
    
    if var urlRequest = try? endpoint.urlRequest() {
        urlRequest.timeoutInterval = 15
        closure(.success(urlRequest))
    } else {
        closure(.failure(MoyaError.requestMapping(endpoint.url)))
    }
}

let ApiProvider = MoyaProvider<Api>(requestClosure: timeoutClosure)

enum Api {
    
    /// 新闻频道
    case allChannel
    /// 频道列表
    case allChannelList(Int, Int)
}

extension Api: TargetType {
    
    var baseURL: URL {
        return URL(string: HostIP)!
    }
    
    var path: String {
        
        switch self {
        case .allChannel:
            return "v2/allchannel"
        case .allChannelList(_, _):
            return "v2/AllChannelList"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .post
        }
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
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
                                    "pageIndex": "\(page)",
                                    "elementsCountPerPage" : "20"]
        }
        
        return .requestParameters(parameters: parmeters, encoding: JSONEncoding.default)
    }
    
    var headers: [String : String]? {
        return nil
    }
}
