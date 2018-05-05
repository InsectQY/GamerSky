//
//  Moya+Codable.swift
//  Moya+Codable
//
//  Created by QY on 2018/3/31.
//  Copyright © 2018年 QY. All rights reserved.
//

import Foundation
import Moya

public extension MoyaProvider {
    
    // MARK: - 请求数据（返回一个对象模型）
    @discardableResult
    public func request<T: Codable>(_ target: Target,
                                  objectModel: T.Type,
                                  path: String? = nil,
                                  success: ((_ returnData: T) -> ())?, failure: ((_ Error: MoyaError) -> ())?) -> Cancellable? {
        
        return request(target, completion: {
            
            if let error = $0.error {
                
                failure?(error)
                return
            }
            
            do {
                
                guard let returnData = try $0.value?.mapObject(objectModel.self, path: path) else {
                    return
                }
                success?(returnData)
            } catch {
                failure?(MoyaError.jsonMapping($0.value!))
            }
        })
    }
    
    // MARK: - 请求数据（返回一个数组模型）
    @discardableResult
    public func request<T: Codable>(_ target: Target,
                                  arrayModel: T.Type,
                                  path: String? = nil,
                                  success: ((_ returnData: [T]) -> ())?, failure: ((_ Error: MoyaError) -> ())?) -> Cancellable? {
        
        return request(target, completion: {
            
            if let error = $0.error {
                
                failure?(error)
                return
            }
            
            do {
                
                guard let returnData = try $0.value?.mapArray(arrayModel.self, path: path) else {
                    return
                }
                success?(returnData)
            } catch {
                failure?(MoyaError.jsonMapping($0.value!))
            }
        })
    }
}
