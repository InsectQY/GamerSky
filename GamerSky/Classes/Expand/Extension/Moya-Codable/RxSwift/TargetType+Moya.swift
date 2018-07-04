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

extension TargetType {
    
    public var cachedKey: String {
        return "\(URL(target: self).absoluteString)?\(task.parameters)"
    }
    
    public func request() -> Single<Response> {
        return MultiApiProvider.rx.request(.target(self))
    }
    
    public func request<T: Codable>(objectModel: T.Type,
                                    path: String? = nil) -> Single<T> {
        return request().mapObject(objectModel, path: path)
    }
    
    public func request<T: Codable>(arrayModel: T.Type,
                                    path: String? = nil) -> Single<[T]> {
        return request().mapArray(arrayModel, path: path)
    }
    
    public func cachedObject<T: Codable>(_ type: T.Type,
                                         onCache: ((T) -> ())?) -> TargetType {
        if let entry = CacheManager.object(ofType: type, forKey: cachedKey) {
            onCache?(entry)
        }
        return self
    }
    
    public var cache: Observable<Self> {
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
