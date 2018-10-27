//
//  NewsListViewModel.swift
//  GamerSky
//
//  Created by QY on 2018/7/4.
//  Copyright © 2018年 QY. All rights reserved.
//

import Foundation
import RxDataSources

class NewsListViewModel: NSObject {
    
    struct NewsListInput {
        
        let nodeID: Int
        let requestCommand = PublishSubject<Bool>()
    }
    
    struct NewsListOutput: OutputRefreshProtocol {
        
        let refreshState = Variable<RefreshState>(.none)
        let sections: Driver<[NewsListSection]>
        let banners = Variable<[ChannelList]?>([])
        
        init(sections : Driver<[NewsListSection]>) {
            self.sections = sections
        }
    }
}

extension NewsListViewModel: ViewModelable {

    typealias Input = NewsListInput
    typealias Output = NewsListOutput

    func transform(input: NewsListViewModel.NewsListInput) -> NewsListViewModel.NewsListOutput {

        var page = 1
        
        let vmDatas = Variable<[ChannelList]>([])

        let temp_sections = vmDatas.asObservable().map {
            [NewsListSection(items: $0)]
        }.asDriver(onErrorJustReturn: [])
        
        let output = NewsListOutput(sections: temp_sections)
        
        input.requestCommand.asDriver(onErrorJustReturn: true)
        .flatMapLatest { (isPull) -> SharedSequence<DriverSharingStrategy, [ChannelList]> in
            
            page = isPull ? 1 : page + 1
            return NewsApi.allChannelList(page, input.nodeID)
                .cache
                .request()
                .mapObject([ChannelList].self)
                .asDriver(onErrorJustReturn: [])
        }.drive(onNext: {
            
            if page == 1 {
                
                vmDatas.value = $0
                vmDatas.value.removeFirst()
                output.banners.value = $0.first?.childElements
                output.refreshState.value = .endHeaderRefresh
                output.refreshState.value = .endFooterRefresh
            }else {
                
                vmDatas.value += $0
                output.refreshState.value = $0.count > 0 ? .endFooterRefresh : .noMoreData
            }
        }).disposed(by: rx.disposeBag)
        
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
