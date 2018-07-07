//
//  TargetType+Moya.swift
//  Moya+Codable
//
//  Created by QY on 2018/5/18.
//  Copyright © 2018年 QY. All rights reserved.
//

import Moya
import RxSwift
import RxMoya
import Cache

private var cachedTimeKey: Void?

public extension TargetType {
    
    var cachedKey: String {
        return "\(URL(target: self).absoluteString)?\(task.parameters)"
    }
    
    func request() -> Single<Response> {
        return ApiProvider.rx.request(.target(self))
    }
    
    func cachedObject<T: Codable>(_ type: T.Type) -> T? {
        
        if let entry = CacheManager.object(ofType: type, forKey: cachedKey) {
            return entry
        }
        return nil
    }
    
    var cachedResponse: Response? {
        
        if let response = CacheManager.response(forKey: cachedKey) {
            return response
        }
        return nil
    }
    
    func onCache<T: Codable>(_ type: T.Type,
                                         _ onCache: ((T) -> ())?) -> OnCache<Self, T> {
        
        if let object = cachedObject(type) {onCache?(object)}
        return OnCache(self)
    }
    
    var cache: Observable<Self> {
        return Observable.just(self)
    }
}

extension Task {
    
    public var parameters: String {
        switch self {
        case .requestParameters(let parameters, _):
            return "\(parameters)"
        case .requestCompositeData(_, let urlParameters):
            return "\(urlParameters)"
        case let .requestCompositeParameters(bodyParameters, _, urlParameters):
            return "\(bodyParameters)\(urlParameters)"
        default:
            return ""
        }
    }
}
