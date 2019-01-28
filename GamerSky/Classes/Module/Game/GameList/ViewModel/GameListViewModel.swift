//
//  GameListViewModel.swift
//  GamerSky
//
//  Created by Insect on 2019/1/28.
//  Copyright © 2019 engic. All rights reserved.
//

import Foundation

final class GameListViewModel: ViewModel {
    
    struct Input {
        
        let headerRefresh: Driver<Void>
        let footerRefresh: Driver<Void>
    }
    
    struct Output {
        
        let endHeaderRefresh: Driver<Bool>
        let endFooterRefresh: Driver<RxMJRefreshFooterState>
        let items: Driver<[GameChildElement]>
    }
}

extension GameListViewModel: ViewModelable {
    
    func transform(input: GameListViewModel.Input) -> GameListViewModel.Output {

        // HUD 状态
        let HUDState = PublishRelay<UIState>()
        
        let elements = BehaviorRelay<[GameChildElement]>(value: [])
        
        var page = 1
        
        let header = input.headerRefresh.then(page = 1)
        .flatMapLatest { [unowned self] in
            self.request(page: page, relay: HUDState)
        }
        
        let footer = input.footerRefresh.then(page += 1)
        .flatMapLatest { [unowned self] in
            self.request(page: page, relay: HUDState)
        }
        
        // 绑定数据源
        header.map({$0.childelements})
        .drive(elements)
        .disposed(by: disposeBag)
        
        footer.map({elements.value + $0.childelements})
        .drive(elements)
        .disposed(by: disposeBag)
        
        // 头部状态
        let endHeader = header.map {_ in false}
        // 尾部状态
        let endFooter = Driver.merge(header.map({_ in RxMJRefreshFooterState.default}), footer.map({_ in RxMJRefreshFooterState.default})).startWith(.hidden)
        
        let output = Output(endHeaderRefresh: endHeader, endFooterRefresh: endFooter, items: elements.asDriver())
        return output
    }
    
    func request(page: Int, relay: PublishRelay<UIState>) -> Driver<GameList> {
        
        return GameApi.gameList(page)
        .request()
        .trackState(relay)
        .mapObject(GameList.self)
        .asDriverOnErrorJustComplete()
    }
}
