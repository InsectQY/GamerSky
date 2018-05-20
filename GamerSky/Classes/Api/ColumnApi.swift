//
//  ColumnApi.swift
//  GamerSky
//
//  Created by QY on 2018/5/20.
//  Copyright © 2018年 QY. All rights reserved.
//

import Moya

enum ColumnApi {
    /// 全部栏目
    case columnNodeList
    /// 最新动态(参数依次是: page, 频道 ID)
    case columnContent(Int, Int)
}

extension ColumnApi: TargetType {
    
    var baseURL: URL {
        return URL(string: AppHostIP)!
    }
    
    var path: String {
        
        switch self {

        case .columnNodeList:
            return "v2/ColumnNodeList"
        case .columnContent:
            return "v2/ColumnContent"
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
            
        case .columnNodeList:
            parmeters["request"] = ["date" : 1]
        case let .columnContent(page, id):
            parmeters["request"] = ["id" : id,
                                    "pageIndex" : page,
                                    "elementsCountPerPage" : 20]
        }
        
        return .requestParameters(parameters: parmeters, encoding: JSONEncoding.default)
    }
    
    var headers: [String : String]? {
        return nil
    }
}
