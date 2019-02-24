//
//  GameCommentListViewModel.swift
//  GamerSky
//
//  Created by Insect on 2019/1/21.
//  Copyright © 2019 engic. All rights reserved.
//

import Foundation

final class GameCommentListViewModel: ViewModel {
    
    struct Input {
        
    }
    
    struct Output {

    }
}

extension GameCommentListViewModel: ViewModelable {
    
    func transform(input: GameCommentListViewModel.Input) -> GameCommentListViewModel.Output {
        
        let output = Output()
        return output
    }
}
