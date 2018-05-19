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

public extension ObservableType where E: TargetType {
    
    public func request<T: Codable>(objectModel: T.Type,
                                    path: String? = nil) -> Observable<T> {
        
        return flatMap { target -> Observable<T> in
            
            if let entry = CacheManager.default.object(ofType: objectModel, forKey: target.cachedKey) {
                
                return target.request(objectModel: objectModel, path: path).setObject(for: target).asObservable().startWith(entry)
            }
            return target.request(objectModel: objectModel, path: path).asObservable()
        }
    }
    
//    public func request<T: Codable>(arrayModel: T.Type,
//                                    path: String? = nil) -> Observable<[T]> {
//        
//        return flatMap { target -> Observable<[T]> in
//            
//            if let entry = CacheManager.default.object(ofType: arrayModel, forKey: target.cachedKey) {
//                
//                return target.request(arrayModel: arrayModel, path: path).setObject(for: target).asObservable().startWith(entry)
//            }
//            return target.request(arrayModel: arrayModel, path: path).asObservable()
//        }
//    }
}

public extension ObservableType where E == Response {
    
    public func mapObject<T: Codable>(_ type: T.Type, _ path: String? = nil) -> Observable<T> {
        return flatMap { response -> Observable<T> in
            return Observable.just(try response.mapObject(type, path: path))
        }
    }
    
    public func mapArray<T: Codable>(_ type: T.Type, _ path: String? = nil) -> Observable<[T]> {
        return flatMap { response -> Observable<[T]> in
            return Observable.just(try response.mapArray(type, path: path))
        }
    }
}
