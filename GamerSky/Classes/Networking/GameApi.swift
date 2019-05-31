//
//  GameApi.swift
//  GamerSky
//
//  Created by QY on 2018/5/20.
//  Copyright © 2018年 QY. All rights reserved.
//

import Moya

enum GameApi {
   
    /// 特色专题(参数是 page)
    case gameSpecialList(Int)
    /// 游戏类型(参数依次是: page, 游戏类型)
    case gameHomePage(Int, GameType)
    /// 游戏排行(参数依次是: page, 排行榜类型, 游戏种类ID, 年代[热门榜总榜才有年])
    case gameRankingList(Int, GameRankingType, Int, String)
    /// 找游戏, 游戏标签
    case gameTags
    /// 特色专题详情(参数依次是: page, nodeID)
    case gameSpecialDetail(Int, Int)
    /// 特色专题列表
    case gameSpecialSubList(Int)
    /// 发售列表(参数依次是: 时间, 排序方式)
    case twoGameList(Int, GameSellSort)
    /// 玩家点评(参数依次是: page, 评论方式)
    case gameReviewList(Int,GameCommentType)
    /// 找游戏
    case gameList(Int)
    /// 游戏详情(参数依次是: 游戏ID)
    case gameDetail(Int)
}

extension GameApi: TargetType {
    
    var baseURL: URL {
        return URL(string: Configs.Network.appHostUrl)!
    }
    
    var path: String {
        
        switch self {
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
        case .gameSpecialSubList:
            return "game/gameSpecialSubList"
        case .twoGameList:
            return "v2/twoGameList"
        case .gameReviewList:
            return "game/reviewList"
        case .gameList:
            return "game/GameList"
        case .gameDetail:
            return "v2/TwoGameDetails"
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
            
        case let .gameSpecialList(page):
            return .requestParameters(parameters: ["nodeId" : "1",
                                                  "pageIndex" : page,
                                                  "elementsCountPerPage": 20], encoding: JSONEncoding.default)
        case let .gameHomePage(page, type):
            return .requestParameters(parameters: ["extraField1" : "Position,AllTimeT",
                                                   "extraField2" : "wantplayCount,gsScore",
                                                   "group" : type.rawValue,
                                                   "pageIndex" :  page,
                                                   "elementsCountPerPage" : 20], encoding: JSONEncoding.default)
        case let .gameRankingList(page, rankType, gameClass, annualClass):
            return .requestParameters(parameters: ["type" : rankType.rawValue,
                                                   "gameClass" : gameClass,
                                                   "annualClass" : annualClass,
                                                   "extraField1" : "Position,GameType",
                                                   "extraField2" : "gsScore,gameTag",
                                                   "pageIndex" : page,
                                                   "elementsCountPerPage" : 20], encoding: JSONEncoding.default)
        case let .gameSpecialDetail(page , nodeID):
            return .requestParameters(parameters: ["extraField1" : "Position,GameType",
                                                   "extraField2" : "gsScore,gameTag",
                                                   "extraField3" : "largeImage,description",
                                                   "nodeId" : nodeID,
                                                   "pageIndex" : page,
                                                   "elementsCountPerPage" : 20], encoding: JSONEncoding.default)
        case let .gameSpecialSubList(ID):
            return .requestParameters(parameters: ["nodeId" : ID], encoding: JSONEncoding.default)
        case let .twoGameList(date, sort):
            return .requestParameters(parameters: ["nodeIds" : "1751",
                                                   "date" : date,
                                                   "type" : "current",
                                                   "pageIndex" : 1,
                                                   "elementsCountPerPage" : 100,
                                                   "order" : sort.rawValue], encoding: JSONEncoding.default)
        case let .gameReviewList(page, type):
            return .requestParameters(parameters: ["extraField1" : "Position,GameType",
                                                   "extraField2" : "gsScore,gameTag",
                                                   "extraField3" : "largeImage,description",
                                                   "type" : type.rawValue,
                                                   "pageIndex" : page,
                                                   "elementsCountPerPage" : 20], encoding: JSONEncoding.default)
        case let .gameList(page):
            return .requestParameters(parameters: ["nodeId" : 20039,
                                                   "platform" : 0,
                                                   "sellTime" : 0,
                                                   "company" : 0,
                                                   "chinese" : 0,
                                                   "gameTag" : 0,
                                                   "orderBy" : "hot",
                                                   "orderSort" : "desc",
                                                   "selling" : 0,
                                                   "pageIndex" : page,
                                                   "elementsCountPerPage" : 21], encoding: JSONEncoding.default)
        case let .gameDetail(contentId):
            return .requestParameters(parameters: ["contentId" : contentId,
                                                   "userId" : 2303496], encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
