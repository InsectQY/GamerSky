//
//  GameRankingListViewModel.swift
//  GamerSky
//
//  Created by Insect on 2019/1/21.
//  Copyright © 2019 engic. All rights reserved.
//

import Foundation

final class GameRankingListViewModel: RefreshViewModel {
    
    struct Input {
        
        /// 游戏种类 ID
        let gameClassID: Int
        /// 年代
        let annualClass: String
        /// 排名方式
        let rankingType: GameRankingType = .fractions
    }
    
    struct Output {
        
        /// 数据源
        let items: Driver<[GameSpecialDetail]>
    }
}

extension GameRankingListViewModel: ViewModelable {
    
    func transform(input: GameRankingListViewModel.Input) -> GameRankingListViewModel.Output {

        /// 数据源
        let elements = BehaviorRelay<[GameSpecialDetail]>(value: [])

        var page = 1
        
        // 加载最新
        let loadNew = refreshOutput
        .headerRefreshing
        .then(page = 1)
        .flatMapLatest { [unowned self] _ in
            self.request(page: page,
                         rankingType: input.rankingType,
                         gameClassID: input.gameClassID,
                         annualClass: input.annualClass)
        }
        
        // 加载更多
        let loadMore = refreshOutput
        .footerRefreshing
        .then(page += 1)
        .flatMapLatest { [unowned self] _ in
            self.request(page: page,
                         rankingType: input.rankingType,
                         gameClassID: input.gameClassID,
                         annualClass: input.annualClass)
        }
        
        // 数据源
        loadNew
        .drive(elements)
        .disposed(by: disposeBag)
        
        loadMore
        .drive(elements.append)
        .disposed(by: disposeBag)

        // 头部刷新状态
        loadNew
        .mapTo(false)
        .drive(refreshInput.headerRefreshState)
        .disposed(by: disposeBag)

        // 尾部刷新状态
        Driver.merge(
            loadNew.map { _ in
                RxMJRefreshFooterState.default
            },
            loadMore.map { _ in
                RxMJRefreshFooterState.default
            }
        )
        .startWith(.hidden)
        .drive(refreshInput.footerRefreshState)
        .disposed(by: disposeBag)

        let output = Output(items: elements.asDriver())

        return output
    }
}

extension GameRankingListViewModel {

    /// 加载某条评论的回复
    func request(page: Int,
                 rankingType: GameRankingType,
                 gameClassID: Int,
                 annualClass: String) -> Driver<[GameSpecialDetail]> {

        return  GameApi.gameRankingList(page,
                                        rankingType,
                                        gameClassID,
                                        annualClass)
                .request()
                .mapObject([GameSpecialDetail].self)
                .trackActivity(loading)
                .trackError(refreshError)
                .asDriverOnErrorJustComplete()
    }
}
