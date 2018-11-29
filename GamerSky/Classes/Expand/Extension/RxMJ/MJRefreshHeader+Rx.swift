//
//  MJRefreshHeader+Rx.swift
//  RxMJ
//
//  Created by liubo on 2018/9/17.
//

import Foundation
import class MJRefresh.MJRefreshHeader
import RxSwift
import RxCocoa

public extension Reactive where Base: MJRefreshHeader {
    
    public var beginRefreshing: Binder<Void> {
        return Binder(base) { (header, _) in
            header.beginRefreshing()
        }
    }
    
    public var isRefreshing: Binder<Bool> {
        return Binder(base) { header, refresh in
            refresh ? header.beginRefreshing() : header.endRefreshing()
        }
    }
}
