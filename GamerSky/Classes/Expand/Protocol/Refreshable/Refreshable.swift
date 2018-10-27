//
//  Refreshable.swift
//  GamerSky
//
//  Created by QY on 2018/7/4.
//  Copyright © 2018年 QY. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import MJRefresh

enum RefreshState {
    
    case none
    case beingHeaderRefresh
    case endHeaderRefresh
    case beingFooterRefresh
    case endFooterRefresh
    case noMoreData
}

protocol OutputRefreshProtocol {
    /// 告诉外界的tableView当前的刷新状态
    var refreshState: Variable<RefreshState> {get}
}

extension OutputRefreshProtocol {
    
    func autoSetRefreshHeaderState(header: MJRefreshHeader? = nil, footer: MJRefreshFooter? = nil) -> Disposable {
        
        return refreshState.asObservable().subscribe(onNext: { (state) in
            switch state {
                
            case .beingHeaderRefresh:
                header?.beginRefreshing()
            case .endHeaderRefresh:
                header?.endRefreshing()
            case .beingFooterRefresh:
                footer?.beginRefreshing()
            case .endFooterRefresh:
                footer?.endRefreshing()
            case .noMoreData:
                footer?.endRefreshingWithNoMoreData()
            default:
                break
            }
        })
    }
}

protocol Refreshable {
    
}

extension Refreshable where Self: UIViewController {
    
    func initRefreshHeader(_ scrollView: UIScrollView, _ action: (() -> ())?) -> MJRefreshHeader {
        
        scrollView.mj_header = QYRefreshHeader(refreshingBlock: { action?() })
        return scrollView.mj_header
    }
    
    func initRefreshFooter(_ scrollView: UIScrollView, _ action: (() -> ())?) -> MJRefreshFooter {
        
        scrollView.mj_footer = QYRefreshFooter(refreshingBlock: { action?() })
        return scrollView.mj_footer
    }
}

extension Refreshable where Self: UIScrollView {
    
    func initRefreshHeader(_ action: (() -> ())?) -> MJRefreshHeader {
        
        mj_header = QYRefreshHeader(refreshingBlock: { action?() })
        return mj_header
    }
    
    func initRefreshFooter(_ action: (() -> ())?) -> MJRefreshFooter {
        
        mj_footer = QYRefreshFooter(refreshingBlock: { action?()})
        return mj_footer
    }
}
