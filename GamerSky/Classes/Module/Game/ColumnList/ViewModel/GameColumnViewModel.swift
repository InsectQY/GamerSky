//
//  GameColumnViewModel.swift
//  GamerSky
//
//  Created by Insect on 2019/1/21.
//  Copyright © 2019 engic. All rights reserved.
//

import Foundation

final class GameColumnViewModel: RefreshViewModel {
    
    struct Input {}
    
    struct Output {
        /// 数据源
        let items: Driver<[GameSpecialList]>
    }
}

extension GameColumnViewModel: ViewModelable {
    
    func transform(input: GameColumnViewModel.Input) -> GameColumnViewModel.Output {

        /// 数据源
        let elements = BehaviorRelay<[GameSpecialList]>(value: [])

        let output = Output(items: elements.asDriver())

        // 加载最新
        let loadNew = refreshOutput
        .headerRefreshing
        .flatMapLatest { [unowned self] _ in
            self.request()
        }
        
        // 数据源
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

extension GameColumnViewModel {

    func request() -> Driver<[GameSpecialList]> {

        return   GameApi.gameSpecialList(1)
                .request()
                .mapObject([GameSpecialList].self)
                .trackActivity(loading)
                .trackError(refreshError)
                .asDriverOnErrorJustComplete()
    }
}
