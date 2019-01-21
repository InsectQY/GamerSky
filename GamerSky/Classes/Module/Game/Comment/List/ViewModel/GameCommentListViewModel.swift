//
//  GameCommentListViewModel.swift
//  GamerSky
//
//  Created by Insect on 2019/1/21.
//  Copyright © 2019 engic. All rights reserved.
//

import Foundation

final class GameCommentListViewModel {
    
    struct Input {
        
    }
    
    struct Output {

    }
}

extension GameCommentListViewModel: ViewModelable, HasDisposeBag {
    
    func transform(input: GameCommentListViewModel.Input) -> GameCommentListViewModel.Output {

        // HUD 状态
        let HUDState = PublishRelay<UIState>()
        
        let output = Output()
        return output
    }
}
