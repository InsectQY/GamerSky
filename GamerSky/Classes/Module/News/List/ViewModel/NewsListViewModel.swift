//
//  NewsListViewModel.swift
//  GamerSky
//
//  Created by QY on 2018/7/4.
//  Copyright © 2018年 QY. All rights reserved.
//

import Foundation

final class NewsListViewModel: RefreshViewModel {
    
    struct NewsListInput {
        
        let nodeID: Int
    }
    
    struct NewsListOutput {

        let items: Driver<[ChannelList]>
        let banners: Driver<[ChannelList]?>
    }
}

extension NewsListViewModel: ViewModelable {

    func transform(input: NewsListViewModel.NewsListInput) -> NewsListViewModel.NewsListOutput {

        var page = 1
        
        let elements = BehaviorRelay<[ChannelList]>(value: [])
        let banners = BehaviorRelay<[ChannelList]?>(value: [])

        let laodNew = refreshOutput
        .headerRefreshing
        .then(page = 1)
        .flatMapLatest { [unowned self] in
            self.request(page: page,
                         nodeID: input.nodeID)
        }
        
        let loadMore = refreshOutput
        .footerRefreshing
        .then(page += 1)
        .flatMapLatest { [unowned self] in
            self.request(page: page,
                         nodeID: input.nodeID)
        }

        laodNew.map { lists -> [ChannelList] in
            
            var lists = lists
            lists.removeFirst()
            return lists
        }
        .drive(elements)
        .disposed(by: disposeBag)
        
        loadMore
        .drive(elements.append)
        .disposed(by: disposeBag)
        
        laodNew.map { $0.first?.childElements }
        .drive(banners)
        .disposed(by: disposeBag)
        
        // 头部刷新状态
        laodNew
        .mapTo(false)
        .drive(refreshInput.headerRefreshState)
        .disposed(by: disposeBag)

        // 尾部刷新状态
        Driver.merge(
            laodNew.map { _ in
                RxMJRefreshFooterState.default
            },
            loadMore.map { _ in
                RxMJRefreshFooterState.default
            }
        )
        .startWith(.hidden)
        .drive(refreshInput.footerRefreshState)
        .disposed(by: disposeBag)

        let output = NewsListOutput(items: elements.asDriver(),
                                    banners: banners.asDriver())

        return output
    }
}

extension NewsListViewModel {

    func request(page: Int, nodeID: Int) -> Driver<[ChannelList]> {

        return  NewsApi
                .allChannelList(page, nodeID)
                .request()
                .mapObject([ChannelList].self)
                .trackActivity(loading)
                .trackError(refreshError)
                .asDriverOnErrorJustComplete()
    }
}
