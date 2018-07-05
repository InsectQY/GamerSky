//
//  GameHomeViewModel.swift
//  GamerSky
//
//  Created by Insect on 2018/7/4.
//  Copyright © 2018年 engic. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class GameHomeViewModel: NSObject {

    private let vmDatas = Variable<[([GameInfo], [GameInfo],[GameSpecialList],[GameInfo],[[GameInfo]],[GameInfo], [GameTag], [GameHomeSectionModel])]>([])
    
    struct GameHomeInput {
        
    }
    
    struct GameHomeOutput: OutputRefreshProtocol {
        
        let refreshStatus = Variable<RefreshStatus>(.none)
        let sections: Driver<[GameHomeSection]>
        let requestCommand = PublishSubject<Void>()
    }
}

extension GameHomeViewModel: ViewModelable {
    
    typealias Input = GameHomeInput
    typealias Output = GameHomeOutput
    
    func transform(input: GameHomeViewModel.GameHomeInput) -> GameHomeViewModel.GameHomeOutput {
        
        let temp_sections = vmDatas.asObservable().map { (sections) -> [GameHomeSection] in
            
            return sections.map({ (symbol1Data, symbol2Data, symbol3Data, symbol4Data, symbol5Data, symbol6Data, symbol7Data, symbol8Data) -> GameHomeSection in
                
                return GameHomeSection(gameSpecialDetail: symbol1Data, hotGame: symbol2Data, gameColumn: symbol3Data, waitSellGame: symbol4Data, rankingGame: symbol5Data, expectedGame: symbol6Data, gameTags: symbol7Data, items: symbol8Data)
            })
        }.asDriver(onErrorJustReturn: [])
        
        let output = GameHomeOutput(sections: temp_sections)
        
        output.requestCommand.subscribe(onNext: { [weak self] in
            
            guard let `self` = self else {return}
            // sectionHeader 数据
            let data = try! Data(contentsOf: Bundle.main.url(forResource: "GameHomeSectionData", withExtension: "plist")!)
            let sectionData = try! PropertyListDecoder().decode([GameHomeSectionModel].self, from: data)
            
            // 新游推荐
            let symbol1 = GameApi.gameSpecialDetail(1, 13)
            .cache
            .request(objectModel: BaseModel<[GameInfo]>.self)
            
            // 最近大家都在玩
            let symbol2 = GameApi.gameHomePage(1, .hot)
            .cache
            .request(objectModel: BaseModel<[GameInfo]>.self)
            
            // 特色专题
            let symbol3 = GameApi.gameSpecialList(1)
            .cache
            .request(objectModel: BaseModel<[GameSpecialList]>.self)
            
            // 即将发售
            let symbol4 = GameApi.gameHomePage(1, .waitSell)
            .cache
            .request(objectModel: BaseModel<[GameInfo]>.self)
            
            // 高分榜
            let symbol5 = GameApi.gameRankingList(1, .fractions, 0, "all")
            .cache
            .request(objectModel: BaseModel<[GameInfo]>.self)
            .map({[Array($0.result.prefix(5))]})
            
            // 热门榜
            let symbol6 = GameApi.gameRankingList(1, .hot, 0, "all")
            .cache
            .request(objectModel: BaseModel<[GameInfo]>.self)
            .map({[Array($0.result.prefix(5))]})
            
            // 最期待游戏
            let symbol7 = GameApi.gameHomePage(1, .expected)
            .cache
            .request(objectModel: BaseModel<[GameInfo]>.self)
            
            // 找游戏
            let symbol8 = GameApi.gameTags
            .cache
            .request(objectModel: BaseModel<[GameTag]>.self)
            
            Observable
            .zip(symbol1, symbol2, symbol3, symbol4, symbol5, symbol6,symbol7, symbol8)
            .subscribe(onNext: { (symbol1Data, symbol2Data, symbol3Data, symbol4Data, symbol5Data, symbol6Data,symbol7Data,symbol8Data) in
                
                var rankingGame = symbol5Data
                rankingGame += symbol6Data
                var sectionModels: [([GameInfo], [GameInfo],[GameSpecialList],[GameInfo],[[GameInfo]],[GameInfo], [GameTag], [GameHomeSectionModel])] = []
                    sectionModels
                    .append((symbol1Data.result,symbol2Data.result,symbol3Data.result,symbol4Data.result,rankingGame,symbol7Data.result,symbol8Data.result, sectionData))
                self.vmDatas.value = sectionModels
                
                output.refreshStatus.value = .endHeaderRefresh
            }).disposed(by: self.rx.disposeBag)
        }, onError: { (error) in
            
        }).disposed(by: self.rx.disposeBag)
        return output
    }
}

struct GameHomeSection {
    
    /// 新游推荐
    var gameSpecialDetail: [GameInfo]
    /// 最近大家都在玩
    var hotGame: [GameInfo]
    /// 特色专题
    var gameColumn: [GameSpecialList]
    /// 即将发售
    var waitSellGame: [GameInfo]
    /// 排行榜
    var rankingGame: [[GameInfo]]
    /// 最期待游戏
    var expectedGame: [GameInfo]
    /// 找游戏
    var gameTags: [GameTag]
    
    var items: [Item]
}

extension GameHomeSection: SectionModelType {

    typealias Item = GameHomeSectionModel
    
    init(original: GameHomeSection, items: [Item]) {
        
        self = original
        self.items = items
    }
}
