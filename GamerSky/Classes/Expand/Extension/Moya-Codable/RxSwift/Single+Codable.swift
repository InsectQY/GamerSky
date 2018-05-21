//
//  PrimitiveSequence + Codable.swift
//  GamerSky
//
//  Created by QY on 2018/5/5.
//  Copyright © 2018年 QY. All rights reserved.
//

import RxSwift
import Moya
import Cache

public extension PrimitiveSequence where TraitType == SingleTrait, ElementType: TargetType {
    
    public func request<T: Codable>(objectModel: T.Type,
                                    path: String? = nil) -> Single<T> {
        return flatMap { target -> Single<T> in
            return target.request(objectModel: objectModel, path: path).setObject(for: target)
        }
    }
    
    public func request<T: Codable>(arrayModel: T.Type,
                                    path: String? = nil) -> Single<[T]> {
        return flatMap { target -> Single<[T]> in
            return target.request(arrayModel: arrayModel, path: path).setObject(for: target)
        }
    }
}

public extension PrimitiveSequence where TraitType == SingleTrait, ElementType == Response {
    
    public func mapObject<T: Codable>(_ type: T.Type, path: String? = nil) -> Single<T> {
        return flatMap { response -> Single<T> in
            return Single.just(try response.mapObject(type, path: path))
        }
    }
    
    public func mapArray<T: Codable>(_ type: T.Type, path: String? = nil) -> Single<[T]> {
        return flatMap { response -> Single<[T]> in
            return Single.just(try response.mapArray(type, path: path))
        }
    }
}

extension PrimitiveSequence where TraitType == SingleTrait, ElementType: Codable {
    public func setObject(for target: TargetType) -> Single<ElementType> {
        
        return flatMap { object -> Single<ElementType> in
            
            CacheManager.default.setObject(object, forKey: target.cachedKey)
            return Single.just(object)
        }
    }
}
