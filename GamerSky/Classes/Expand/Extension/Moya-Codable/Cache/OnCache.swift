//
//  OnCache.swift
//  GamerSky
//
//  Created by QY on 2018/7/7.
//  Copyright © 2018年 QY. All rights reserved.
//

import Moya
import RxSwift

public struct OnCache<Target: TargetType, T: Codable> {
    
    public let target: Target
    
    init(_ target: Target) {
        self.target = target
    }
    
    public func request() -> Single<T> {
        return target.request().map(T.self).storeCachedObject(for: target)
    }
}
