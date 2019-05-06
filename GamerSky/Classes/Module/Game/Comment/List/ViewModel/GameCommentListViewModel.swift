//
//  GameCommentListViewModel.swift
//  GamerSky
//
//  Created by Insect on 2019/1/21.
//  Copyright © 2019 engic. All rights reserved.
//

import Foundation

final class GameCommentListViewModel: RefreshViewModel {
    
    struct Input {
        let commentType: GameCommentType
    }
    
    struct Output {
        let items: Driver<[GameComment]>
    }
}

extension GameCommentListViewModel: ViewModelable {
    
    func transform(input: GameCommentListViewModel.Input) -> GameCommentListViewModel.Output {

        let elements = BehaviorRelay<[GameComment]>(value: [])

        let output = Output(items: elements.asDriver())

        guard let refresh = unified else { return output }

        var page = 1

        let loadNew = refresh.header
        .asDriver()
        .then(page = 1)
        .flatMapLatest { [unowned self] in
            self.request(page: page, commentType: input.commentType)
        }

        let loadMore = refresh.footer
        .asDriver()
        .then(page += 1)
        .flatMapLatest { [unowned self] in
            self.request(page: page, commentType: input.commentType)
        }

        // 数据源绑定
        loadNew
        .drive(elements)
        .disposed(by: disposeBag)

        loadMore
        .map { elements.value + $0 }
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

extension GameCommentListViewModel {

    func request(page: Int, commentType: GameCommentType) -> Driver<[GameComment]> {

        return  GameApi
                .gameReviewList(page,
                        commentType)
                .request()
                .mapObject([GameComment].self)
                .trackActivity(loading)
                .trackError(refreshError)
                .asDriverOnErrorJustComplete()
    }
}
