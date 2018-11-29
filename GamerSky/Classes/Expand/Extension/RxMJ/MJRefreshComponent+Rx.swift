//
//  MJRefreshComponent+Rx.swift
//  RxMJ
//
//  Created by liubo on 2018/9/17.
//

import Foundation
import class MJRefresh.MJRefreshComponent
import RxSwift
import RxCocoa

public extension Reactive where Base: MJRefreshComponent {
    
    public var refreshing: ControlEvent<Void> {
        let source = Observable<Void>.create { [weak control = self.base] observer in
            if let control = control {
                control.refreshingBlock = {
                    observer.onNext(())
                }
            }
            return Disposables.create()
        }
        return ControlEvent(events: source)
    }
}
