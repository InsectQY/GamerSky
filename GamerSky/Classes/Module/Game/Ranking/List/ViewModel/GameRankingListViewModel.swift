//
//  GameRankingListViewModel.swift
//  GamerSky
//
//  Created by Insect on 2019/1/21.
//  Copyright © 2019 engic. All rights reserved.
//

import Foundation

final class GameRankingListViewModel {
    
    struct Input {
        
        /// 游戏种类 ID
        let gameClassID: Int
        /// 年代
        let annualClass: String
        /// 排名方式
        let rankingType: GameRankingType = .fractions
        
        let headerRefresh: Driver<Void>
        let footerRefresh: Driver<Void>
    }
    
    struct Output {
        
        /// 数据源
        let vmDatas: Driver<[GameSpecialDetail]>
        /// 刷新状态
        let endHeaderRefresh: Driver<Bool>
        let endFooterRefresh: Driver<RxMJRefreshFooterState>
    }
}

extension GameRankingListViewModel: ViewModelable, HasDisposeBag {
    
    func transform(input: GameRankingListViewModel.Input) -> GameRankingListViewModel.Output {

        // HUD 状态
        let HUDState = PublishRelay<UIState>()
        /// 数据源
        let vmDatas = BehaviorRelay<[GameSpecialDetail]>(value: [])
        
        var page = 1
        
        // 加载最新视频
        let header = input.headerRefresh.then(page = 1)
        .flatMapLatest { _ in
            
            GameApi.gameRankingList(page, input.rankingType, input.gameClassID, input.annualClass)
            .request()
            .trackState(HUDState)
            .mapObject([GameSpecialDetail].self)
            .asDriverOnErrorJustComplete()
        }
        
        // 加载更多视频
        let footer = input.footerRefresh.then(page += 1)
        .flatMapLatest { _ in
                
            GameApi.gameRankingList(page, input.rankingType, input.gameClassID, input.annualClass)
            .request()
            .trackState(HUDState)
            .mapObject([GameSpecialDetail].self)
            .asDriverOnErrorJustComplete()
        }
        
        // 数据源
        header.drive(vmDatas)
        .disposed(by: disposeBag)
        
        footer.map({vmDatas.value + $0})
        .drive(vmDatas)
        .disposed(by: disposeBag)
        
        // 头部刷新状态
        let endHeader = header.map { _ in false}
        // 尾部刷新状态
        let endFooter = footer.map { _ in RxMJRefreshFooterState.default}
        
        let output = Output(vmDatas: vmDatas.asDriver(), endHeaderRefresh: endHeader, endFooterRefresh: endFooter)
        return output
    }
}
