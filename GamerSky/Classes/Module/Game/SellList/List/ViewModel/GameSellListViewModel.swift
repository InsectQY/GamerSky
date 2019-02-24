//
//  GameSellListViewModel.swift
//  GamerSky
//
//  Created by Insect on 2018/11/3.
//  Copyright © 2018 engic. All rights reserved.
//

import Foundation

final class GameSellListViewModel: ViewModel {
    
    struct Input {
        
        let date: Int
        let headerRefresh: Driver<Void>
    }
    
    struct Output {
        
        /// 数据源
        let vmDatas: Driver<[GameSellList]>
        /// 刷新状态
        let endHeaderRefresh: Driver<Bool>
    }
}

extension GameSellListViewModel: ViewModelable {
    
    func transform(input: GameSellListViewModel.Input) -> GameSellListViewModel.Output {
        
        let vmDatas = BehaviorRelay<[GameSellList]>(value: [])
        
        let header = input.headerRefresh
        .flatMapLatest {
            
            GameApi.twoGameList(input.date, .popular)
            .cache
            .request()
            .mapObject([GameSellList].self)
            .asDriver(onErrorJustReturn: [])
        }
            
        header.asDriver()
        .drive(vmDatas)
        .disposed(by: disposeBag)
        
        // 头部刷新状态
        let endHeader = header.map { _ in false}
        
        let output = Output(vmDatas: vmDatas.asDriver(), endHeaderRefresh: endHeader)
        return output
    }
}
