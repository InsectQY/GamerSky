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
    public let keyPath: String
    
    init(_ target: Target, _ keyPath: String) {
        
        self.target = target
        self.keyPath = keyPath
    }
    
    public func request() -> Single<T> {
        
        return target.request()
                .mapObject(T.self, atKeyPath: keyPath)
                .storeCachedObject(for: target)
    }
}
