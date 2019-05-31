//
//  ObservableType+Codable.swift
//  Moya+Codable
//
//  Created by QY on 2018/5/5.
//  Copyright © 2018年 QY. All rights reserved.
//

import RxSwift
import Moya
import CleanJSON

public extension ObservableType where E == Response {
    
    func mapObject<T: Codable>(_ type: T.Type, atKeyPath path: String? = nil, using decoder: JSONDecoder = CleanJSONDecoder()) -> Observable<T> {
        
        return map {
            
            guard let response = try? $0.mapObject(type, atKeyPath: path, using: decoder, failsOnEmptyData: true) else {
                throw MoyaError.jsonMapping($0)
            }
            return response
        }
    }
    
    func mapObject<T: Codable>(_ type: T.Type, using decoder: JSONDecoder = CleanJSONDecoder()) -> Observable<T> {
        
        return map {
            
            guard let response = try? $0.mapObject(type, using: decoder) else {
                throw MoyaError.jsonMapping($0)
            }
            return response
        }
    }
}
