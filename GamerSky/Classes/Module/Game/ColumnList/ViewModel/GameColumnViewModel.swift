//
//  GameColumnViewModel.swift
//  GamerSky
//
//  Created by Insect on 2019/1/21.
//  Copyright © 2019 engic. All rights reserved.
//

import Foundation

final class GameColumnViewModel {
    
    struct Input {
        
        let headerRefresh: Driver<Void>
    }
    
    struct Output {
        /// 数据源
        let vmDatas: Driver<[GameSpecialList]>
        /// 刷新状态
        let endHeaderRefresh: Driver<Bool>
    }
}

extension GameColumnViewModel: ViewModelable, HasDisposeBag {
    
    func transform(input: GameColumnViewModel.Input) -> GameColumnViewModel.Output {

        // HUD 状态
        let HUDState = PublishRelay<UIState>()
        /// 数据源
        let vmDatas = BehaviorRelay<[GameSpecialList]>(value: [])
        
        // 加载最新
        let header = input.headerRefresh
        .flatMapLatest { _ in
            
            GameApi.gameSpecialList(1)
            .cache
            .request()
            .trackState(HUDState)
            .mapObject([GameSpecialList].self)
            .asDriver(onErrorJustReturn: [])
        }
        
        // 数据源
        header.drive(vmDatas)
        .disposed(by: disposeBag)
        
        // 头部刷新状态
        let endHeader = header.map { _ in false}
        
        let output = Output(vmDatas: vmDatas.asDriver(), endHeaderRefresh: endHeader)
        return output
    }
}
