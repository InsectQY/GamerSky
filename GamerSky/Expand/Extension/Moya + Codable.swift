//
//  Moya+Codable.swift
//  Moya+Codable
//
//  Created by QY on 2018/3/31.
//  Copyright © 2018年 QY. All rights reserved.
//

import Foundation
import Moya

extension MoyaProvider {

    // MARK: - 请求数据（返回一个对象模型）
    @discardableResult
    open func request<T: Codable>(_ target: Target,
                                  objectModel: T.Type,
                                  path: String? = nil,
                                  success: ((_ returnData: T) -> ())?, failure: ((_ Error: MoyaError) -> ())?) -> Cancellable? {

        return request(target, completion: {

            if let error = $0.error {

                failure?(error)
                return
            }

            do {

                guard let returnData = try $0.value?.mapObject(objectModel.self, path) else {
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
    open func request<T: Codable>(_ target: Target,
                                  arrayModel: T.Type,
                                  path: String? = nil,
                                  success: ((_ returnData: [T]) -> ())?, failure: ((_ Error: MoyaError) -> ())?) -> Cancellable? {

        return request(target, completion: {

            if let error = $0.error {

                failure?(error)
                return
            }

            do {

                guard let returnData = try $0.value?.mapArray(arrayModel.self, path) else {
                    return
                }
                success?(returnData)
            } catch {
                failure?(MoyaError.jsonMapping($0.value!))
            }
        })
    }
}

extension Response {

    // MARK: - 转成对象模型
    func mapObject<T: Codable>(_ type: T.Type, _ path: String? = nil) throws -> T {

        do {
            return try JSONDecoder().decode(T.self, from: try getJsonData(path))
        } catch {
            throw MoyaError.jsonMapping(self)
        }
    }

    // MARK: - 转成数组模型
    func mapArray<T: Codable>(_ type: T.Type, _ path: String? = nil) throws -> [T] {

        do {
            return try JSONDecoder().decode([T].self, from: try getJsonData(path))
        } catch {
            throw MoyaError.jsonMapping(self)
        }
    }

    // MARK: - 获取指定路径数据
    private func getJsonData(_ path: String? = nil) throws -> Data {

        do {

            var jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
            if let path = path {

                guard let specificObject = jsonObject.value(forKeyPath: path) else {
                    throw MoyaError.jsonMapping(self)
                }
                jsonObject = specificObject as AnyObject
            }

            return try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
        } catch {
            throw MoyaError.jsonMapping(self)
        }
    }
}

