//
//  ObservableType+Codable.swift
//  Moya+Codable
//
//  Created by QY on 2018/5/5.
//  Copyright © 2018年 QY. All rights reserved.
//

import RxSwift
import Moya
import RxMoya

extension ObservableType where E: TargetType {
    
    public func request() -> Observable<Response> {
        
        return flatMap { target -> Observable<Response> in
            
            let source = target.request().storeCachedResponse(for: target).asObservable()
            if let response = target.cachedResponse {
                return source.startWith(response)
            }
            return source
        }
    }
}

public extension ObservableType where E == Response {
    
    public func mapObject<T: Codable>(_ type: T.Type, atKeyPath path: String? = nil) -> Observable<T> {
        return map {
            
            guard let response = try? $0.map(type, atKeyPath: path, failsOnEmptyData: true) else {
                throw MoyaError.jsonMapping($0)
            }
            return response
        }
    }
}
