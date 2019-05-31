//
//  GameListViewModel.swift
//  GamerSky
//
//  Created by Insect on 2019/1/28.
//  Copyright © 2019 engic. All rights reserved.
//

import Foundation

final class GameListViewModel: RefreshViewModel {
    
    struct Input {}
    
    struct Output {

        let items: Driver<[GameChildElement]>
    }
}

extension GameListViewModel: ViewModelable {
    
    func transform(input: GameListViewModel.Input) -> GameListViewModel.Output {
        
        let elements = BehaviorRelay<[GameChildElement]>(value: [])

        var page = 1
        
        let loadNew = refreshOutput
        .headerRefreshing
        .then(page = 1)
        .flatMapLatest { [unowned self] in
            self.request(page: page)
        }
        
        let loadMore = refreshOutput
        .footerRefreshing
        .then(page += 1)
        .flatMapLatest { [unowned self] in
            self.request(page: page)
        }
        
        // 绑定数据源
        loadNew
        .map { $0.childelements }
        .drive(elements)
        .disposed(by: disposeBag)
        
        loadMore
        .map { $0.childelements }
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

extension GameListViewModel {


    func request(page: Int) -> Driver<GameList> {

        return  GameApi.gameList(page)
                .request()
                .mapObject(GameList.self)
                .trackActivity(loading)
                .trackError(refreshError)
                .asDriverOnErrorJustComplete()
    }
}
