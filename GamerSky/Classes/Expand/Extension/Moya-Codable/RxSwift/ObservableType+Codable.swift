//
//  ObservableType+Codable.swift
//  Moya+Codable
//
//  Created by QY on 2018/5/5.
//  Copyright © 2018年 QY. All rights reserved.
//

import Foundation
import RxSwift
import Moya

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
