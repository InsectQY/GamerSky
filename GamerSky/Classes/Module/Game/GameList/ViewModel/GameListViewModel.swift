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

        let output = Output(items: elements.asDriver())

        guard let refresh = unified else { return output }

        var page = 1
        
        let loadNew = refresh.header
        .asDriver()
        .then(page = 1)
        .flatMapLatest { [unowned self] in
            self.request(page: page)
        }
        
        let loadMore = refresh.footer
        .asDriver()
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
        .map { elements.value + $0.childelements }
        .drive(elements)
        .disposed(by: disposeBag)
        
        // 头部刷新状态
        loadNew
        .map { _ in false }
        .drive(headerRefreshState)
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
        .drive(footerRefreshState)
        .disposed(by: disposeBag)

        bindErrorToRefreshFooterState(elements.value.isEmpty)

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
