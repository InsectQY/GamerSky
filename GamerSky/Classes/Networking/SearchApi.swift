//
//  SearchApi.swift
//  GamerSky
//
//  Created by QY on 2018/5/20.
//  Copyright © 2018年 QY. All rights reserved.
//

import Moya

enum SearchApi {
    
    /// 热搜
    case hotSearch
    /// 搜索(参数依次是: page, 搜索类型, 搜索内容)
    case twoSearch(Int, SearchType, String)
}

extension SearchApi: TargetType {
    
    var baseURL: URL {
        return URL(string: Configs.Network.appHostUrl)!
    }
    
    var path: String {
        
        switch self {

        case .hotSearch:
            return "v2/SearchHotDict"
        case .twoSearch:
            return "v2/TwoSearch"
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
        
        switch self {
            
        case .hotSearch:
            return .requestParameters(parameters: ["searchType" : "strategy"], encoding: JSONEncoding.default)
        case let .twoSearch(page, searchType, searchKey):
            return .requestParameters(parameters: ["searchType" : searchType.rawValue,
                                                   "searchKey" : searchKey,
                                                   "pageIndex" : page,
                                                   "elementsCountPerPage" : 20], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
