//
//  UserApi.swift
//  GamerSky
//
//  Created by QY on 2018/5/20.
//  Copyright © 2018年 QY. All rights reserved.
//

import Moya

enum UserApi {
    
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
    /// 账号密码登陆(参数依次是: 账号, 密码)
    case twoLogin(String, String)
}

extension UserApi: TargetType {
    
    var baseURL: URL {
        return URL(string: AppHostIP)!
    }
    
    var path: String {
        
        switch self {
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
        case .twoLogin:
            return "v2/TwoLogin"
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
        case let .twoLogin(userInfo, passWord):
            parmeters["request"] = ["userInfo" : userInfo,
                                    "passWord" : passWord]
        }
        
        return .requestParameters(parameters: parmeters, encoding: JSONEncoding.default)
    }
    
    var headers: [String : String]? {
        return nil
    }
}
