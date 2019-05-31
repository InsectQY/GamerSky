//
//  UIState+Rx.swift
//  LightCloud
//
//  Created by GorXion on 2018/5/28.
//  Copyright © 2018年 gaoX. All rights reserved.
//

import RxSwift
import RxCocoa

enum UIState {
    
    case idle
    case loading
    case success(String?)
    case failure(String?)
    
    var isSuccess: Bool {
        switch self {
        case .success:
            return true
        default:
            return false
        }
    }
    
    var isFailure: Bool {
        switch self {
        case .failure:
            return true
        default:
            return false
        }
    }
}

struct UIStateToken<E>: Disposable {
    
    private let _source: Observable<E>
    
    init(source: Observable<E>) {
        _source = source
    }
    
    func asObservable() -> Observable<E> {
        return _source
    }
    
    public func dispose() {}
}

extension ObservableConvertibleType {
    
    /// Toast
    ///
    /// - Parameters:
    ///   - state: UIState publish relay
    ///   - loading: 是否显示loading框
    ///   - success: 成功提示信息
    ///   - failure: 失败提示信息
    /// - Returns: 绑定的序列
    func trackState(_ relay: PublishRelay<UIState>,
                    loading: Bool = true,
                    success: String? = nil,
                    failure: @escaping (Error) -> String? = { $0.errorMessage }) -> Observable<E> {
        return Observable.using({ () -> UIStateToken<E> in
            if loading { relay.accept(.loading) }
            return UIStateToken(source: self.asObservable())
        }, observableFactory: {
            return $0.asObservable().do(onNext: { _ in
                relay.accept(.success(success))
            }, onError: {
                relay.accept(.failure(failure($0)))
            }, onCompleted: {
                relay.accept(.success(nil))
            })
        })
    }
}
