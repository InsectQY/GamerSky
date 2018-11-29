//
//  GameSellListSection.swift
//  GamerSky
//
//  Created by Insect on 2018/11/3.
//  Copyright © 2018 engic. All rights reserved.
//

import RxDataSources

struct GameSellListSection {
    
    var items: [Item]
}

extension GameSellListSection: SectionModelType {
    
    typealias Item = GameSellList
    
    init(original: GameSellListSection, items: [Item]) {
        
        self = original
        self.items = items
    }
}
