//
//  NewsListViewModel.swift
//  GamerSky
//
//  Created by QY on 2018/7/4.
//  Copyright © 2018年 QY. All rights reserved.
//

import Foundation
import RxDataSources

final class NewsListViewModel {
    
    struct NewsListInput {
        
        let nodeID: Int
        let headerRefresh: Driver<Void>
        let footerRefresh: Driver<Void>
    }
    
    struct NewsListOutput {
        
        let endHeaderRefresh: Driver<Bool>
        let endFooterRefresh: Driver<RxMJRefreshFooterState>
        let sections: Driver<[NewsListSection]>
        let banners: Driver<[ChannelList]?>
    }
}

extension NewsListViewModel: ViewModelable, HasDisposeBag {

    typealias Input = NewsListInput
    typealias Output = NewsListOutput

    func transform(input: NewsListViewModel.NewsListInput) -> NewsListViewModel.NewsListOutput {

        var page = 1
        
        let vmDatas = BehaviorRelay<[ChannelList]>(value: [])

        let temp_sections = vmDatas.asObservable().map {
            [NewsListSection(items: $0)]
        }.asDriver(onErrorJustReturn: [])
        
        let header = input.headerRefresh.then(page = 1)
            .flatMapLatest {
                
            NewsApi.allChannelList(page, input.nodeID)
            .cache
            .request()
            .mapObject([ChannelList].self)
            .asDriver(onErrorJustReturn: [])
        }
        
        let footer = input.footerRefresh.then(page += 1)
            .flatMapLatest {
                
            NewsApi.allChannelList(page, input.nodeID)
            .cache
            .request()
            .mapObject([ChannelList].self)
            .asDriver(onErrorJustReturn: [])
        }
        
        header.map { lists -> [ChannelList] in
            
            var lists = lists
            lists.removeFirst()
            return lists
        }.drive(vmDatas)
        .disposed(by: disposeBag)
        
//        footer.map({vmDatas.value + $0}).drive(vmDatas)
//        .disposed(by: disposeBag)
        
        let banners = header.map({$0.first?.childElements})
        
        let endHeader = header.map { _ in false}
        let endFooter = Driver.merge(header.map({_ in RxMJRefreshFooterState.default}), footer.map({_ in RxMJRefreshFooterState.default})).startWith(.hidden)
        
        let output = NewsListOutput(endHeaderRefresh: endHeader, endFooterRefresh: endFooter, sections: temp_sections, banners: banners)
        
        return output
    }
}

struct NewsListSection {
    
    var items: [Item]
}

extension NewsListSection: SectionModelType {
    
    typealias Item = ChannelList
    
    init(original: NewsListSection, items: [Item]) {
        
        self = original
        self.items = items
    }
}
