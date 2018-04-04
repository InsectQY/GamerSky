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
    
    ///////////////  新闻  ///////////////
    /// 新闻频道
    case allChannel
    /// 频道列表(参数依次是: page, 频道 ID)
    case allChannelList(Int, Int)
    
    ///////////////  游戏  ///////////////
    /// 特色专题(参数是 page)
    case gameSpecialList(Int)
    /// 游戏类型(参数依次是: page, 游戏类型)
    case gameHomePage(Int, GameType)
    /// 游戏排行(参数依次是: page, 排行榜类型, 游戏种类ID, 年代[热门榜总榜才有年])
    case gameRankingList(Int, GameRanking, String, String)
    /// 找游戏, 游戏标签
    case gameTags
    /// 新游推荐(参数依次是: page, ID)
    case gameSpecialDetail(Int, String)
    
    ///////////////  圈子  ///////////////
    
    ///////////////  原创  ///////////////
    /// 全部栏目
    case columnNodeList
    /// 最新动态(参数依次是: page, 频道 ID)
    case columnContent(Int, Int)
    
    ///////////////  搜索 ///////////////
    
    /// 热搜
    case hotSearch
    /// 搜索(参数依次是: page, 搜索类型, 搜索内容)
    case twoSearch(Int, SearchType, String)
    
    
    ///////////////  登陆注册 ///////////////
    
    /// 获取短信验证码(参数依次是: 手机号)
    case getVerificationCode(String)
    /// 校验验证码(参数依次是: 手机号, 验证码)
    case checkCode(String, String)
    /// 获取随机用户名
    case getRandomUserName
    /// 注册账号(参数依次是: 手机号, 用户名, 密码, token)
    case register(String, String, String, String)
    /// 第三方登陆(参数依次是: 第三方平台类型, 授权ID)
    case thirdPartyLogin(ThirdPartyLogin, String)
}

extension Api: TargetType {
    
    var baseURL: URL {
        return URL(string: HostIP)!
    }
    
    var path: String {
        
        switch self {
        case .allChannel:
            return "v2/allchannel"
        case .allChannelList:
            return "v2/AllChannelList"
        case .gameSpecialList:
            return "game/gameSpecialList"
        case .gameHomePage:
            return "game/gameHomePage"
        case .gameRankingList:
            return "game/rankingList"
        case .gameTags:
            return "game/GameTags"
        case .gameSpecialDetail:
            return "game/gameSpecialDetail"
        case .columnNodeList:
            return "v2/ColumnNodeList"
        case .columnContent:
            return "v2/ColumnContent"
        case .hotSearch:
            return "v2/SearchHotDict"
        case .twoSearch:
            return "v2/TwoSearch"
        case .getVerificationCode:
            return "v2/GetVerificationCode"
        case .checkCode:
            return "v2/CheckCode"
        case .getRandomUserName:
            return "v2/GetRandomUserName"
        case .register:
            return "v2/Register"
        case .thirdPartyLogin:
            return "v2/ThirdPartyLogin"
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
                                    "pageIndex": page,
                                    "elementsCountPerPage" : 20]
            
        case let .gameSpecialList(page):
            parmeters["request"] = ["nodeId" : "1",
                                    "pageIndex" : page,
                                    "elementsCountPerPage": 20]
        case let .gameHomePage(page, type):
            parmeters["request"] = ["extraField1" : "Position",
                                    "extraField2" : "wantplayCount,gsScore",
                                    "group" : type.rawValue,
                                    "pageIndex" :  page,
                                    "elementsCountPerPage" : 20]
        case let .gameRankingList(page, rankType, gameClass, annualClass):
            parmeters["request"] = ["type" : rankType.rawValue,
                                    "gameClass" : gameClass,
                                    "annualClass" : annualClass,
                                    "extraField1" : "Position",
                                    "extraField2" : "gsScore",
                                    "pageIndex" : page,
                                    "elementsCountPerPage" : 20]
        case let .gameSpecialDetail(page , nodeID):
            parmeters["request"] = ["extraField1" : "Position",
                                    "extraField2" : "gsScore",
                                    "extraField3" : "largeImage,description",
                                    "nodeId" : nodeID,
                                    "pageIndex" : page,
                                    "elementsCountPerPage" : 20]
        case .columnNodeList:
            parmeters["request"] = ["date" : Date()]
        case let .columnContent(page, id):
            parmeters["request"] = ["id" : id,
                                    "pageIndex" : page,
                                    "elementsCountPerPage" : 20]
        case .hotSearch:
            parmeters["request"] = ["searchType" : "strategy"]
        case let .twoSearch(page, searchType, searchKey):
            parmeters["request"] = ["searchType" : searchType.rawValue,
                                    "searchKey" : searchKey,
                                    "pageIndex" : page,
                                    "elementsCountPerPage" : 20]
        case let .getVerificationCode(phoneNumber):
            parmeters["request"] = ["codetype" : 1,
                                    "phoneNumber" : phoneNumber,
                                    "email" : "",
                                    "username" : ""]
        case let .checkCode(phoneNumber, code):
            parmeters["request"] = ["codeType" : 1,
                                    "phone" : phoneNumber,
                                    "email" : "",
                                    "veriCode" : code]
        case .getRandomUserName:
            parmeters["request"] = ["" : ""]
        case let .register(phoneNumber, userName, password, varifyToken):
            parmeters["request"] = ["phoneNumber" : phoneNumber,
                                    "userName" : userName,
                                    "password" : password,
                                    "varifyToken" : varifyToken]
        case let .thirdPartyLogin(thirdParty, thirdPartyID):
            parmeters["request"] = ["thirdParty" : thirdParty.rawValue,
                                    "thirdPartyID" : thirdPartyID]
        default:
            return .requestPlain
        }
        
        return .requestParameters(parameters: parmeters, encoding: JSONEncoding.default)
    }
    
    var headers: [String : String]? {
        return nil
    }
}
