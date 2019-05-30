//
//  GameSellListViewModel.swift
//  GamerSky
//
//  Created by Insect on 2018/11/3.
//  Copyright © 2018 engic. All rights reserved.
//

import Foundation

final class GameSellListViewModel: RefreshViewModel {
    
    struct Input {
        let date: Int
    }
    
    struct Output {
        
        /// 数据源
        let items: Driver<[GameSellList]>
    }
}

extension GameSellListViewModel: ViewModelable {
    
    func transform(input: GameSellListViewModel.Input) -> GameSellListViewModel.Output {
        
        let elements = BehaviorRelay<[GameSellList]>(value: [])

        let output = Output(items: elements.asDriver())

        let loadNew = refreshOutput
        .headerRefreshing
        .flatMapLatest {
            
            GameApi.twoGameList(input.date, .popular)
            .request()
            .mapObject([GameSellList].self)
            .asDriver(onErrorJustReturn: [])
        }
            
        loadNew
        .drive(elements)
        .disposed(by: disposeBag)

        // 头部刷新状态
        loadNew
        .mapTo(false)
        .drive(refreshInput.headerRefreshState)
        .disposed(by: disposeBag)

        return output
    }
}
