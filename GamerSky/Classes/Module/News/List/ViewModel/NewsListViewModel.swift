//
//  NewsListViewModel.swift
//  GamerSky
//
//  Created by QY on 2018/7/4.
//  Copyright © 2018年 QY. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import RxDataSources

class NewsListViewModel: NSObject {
    
    private let vmDatas = Variable<[ChannelList]>([])
    
    private var page = 1
    
    struct NewsListInput {
        
        var nodeID = 0
    }
    
    struct NewsListOutput: OutputRefreshProtocol {
        
        let refreshStatus = Variable<RefreshStatus>(.none)
        let sections: Driver<[NewsListSection]>
        let requestCommand = PublishSubject<Bool>()
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

        let temp_sections = vmDatas.asObservable().map {
            [NewsListSection(items: $0)]
        }.asDriver(onErrorJustReturn: [])
        
        let ourtPut = NewsListOutput(sections: temp_sections)
        
        ourtPut.requestCommand.subscribe(onNext: {[weak self] (isPull) in
            
            guard let `self` = self else { return }
            if isPull {

                self.page = 1
                ourtPut.refreshStatus.value = .endFooterRefresh
                NewsApi.allChannelList(self.page, input.nodeID)
                .cache
                .request(objectModel: BaseModel<[ChannelList]>.self)
                .subscribe(onNext: { response in
                    
                    self.vmDatas.value = response.result
                    self.vmDatas.value.removeFirst()
                    ourtPut.banners.value = response.result.first?.childElements
                    ourtPut.refreshStatus.value = .endHeaderRefresh
                }, onError: { _ in
                    ourtPut.refreshStatus.value = .endHeaderRefresh
                })
                .disposed(by: self.rx.disposeBag)
            }else {
                
                self.page += 1
                ourtPut.refreshStatus.value = .endHeaderRefresh
                NewsApi.allChannelList(self.page, input.nodeID)
                .cache
                .request(objectModel: BaseModel<[ChannelList]>.self)
                .subscribe(onNext: { response in
                    
                    self.vmDatas.value += response.result
                    ourtPut.refreshStatus.value = .endFooterRefresh
                }, onError: { _ in
                    ourtPut.refreshStatus.value = .endFooterRefresh
                })
                .disposed(by: self.rx.disposeBag)
            }
        }, onError: { (error) in
            
        }) {
            
        }.disposed(by: self.rx.disposeBag)
        
        return ourtPut
    }
}

struct NewsListSection {
    
    var items: [Item]
}

extension NewsListSection: SectionModelType {
    
    typealias Item = ChannelList
    
    init(original: NewsListSection, items: [ChannelList]) {
        
        self = original
        self.items = items
    }
}
