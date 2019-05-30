//
//  NewsPageViewModel.swift
//  GamerSky
//
//  Created by QY on 2019/2/24.
//  Copyright © 2019年 engic. All rights reserved.
//

import Foundation

final class NewsPageViewModel: ViewModel {
    
    struct Input {
        
    }
    
    struct Output {

    }

    /// 分类数据
    let category = BehaviorRelay<[Channel]>(value: [])
}

extension NewsPageViewModel: ViewModelable {

    @discardableResult
    func transform(input: NewsPageViewModel.Input) -> NewsPageViewModel.Output {

        NewsApi.allChannel
        .request()
        .mapObject([Channel].self)
        .asDriver(onErrorJustReturn: [])
        .drive(category)
        .disposed(by: disposeBag)

        return Output()
    }
}
