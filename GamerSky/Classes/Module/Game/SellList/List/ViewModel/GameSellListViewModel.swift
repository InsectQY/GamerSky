//
//  GameSellListViewModel.swift
//  GamerSky
//
//  Created by Insect on 2018/11/3.
//  Copyright © 2018 engic. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import NSObject_Rx

final class GameSellListViewModel {
    
    struct Input {
        
        let date: Int
        let requestCommand = PublishSubject<Void>()
    }
    
    struct Output: OutputRefreshProtocol {
        
        let refreshState = Variable<RefreshState>(.none)
        let sections: Driver<[GameSellListSection]>
    }
}

extension GameSellListViewModel: ViewModelable, HasDisposeBag {
    
    func transform(input: GameSellListViewModel.Input) -> GameSellListViewModel.Output {
        
        let vmDatas = Variable<[GameSellList]>([])
        
        let sections = vmDatas.asDriver().map {
            [GameSellListSection(items: $0)]
        }
        let output = Output(sections: sections)
        
        let result = input.requestCommand.asDriverOnErrorJustComplete()
        .flatMapLatest {
            
            GameApi.twoGameList(input.date, .popular)
            .cache
            .request()
            .mapObject([GameSellList].self)
            .asDriver(onErrorJustReturn: [])
        }
            
        result.asDriver()
        .drive(vmDatas)
        .disposed(by: disposeBag)
        
        result.map({_ in RefreshState.endHeaderRefresh})
        .drive(output.refreshState)
        .disposed(by: disposeBag)
        return output
    }
}
