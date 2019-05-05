//
//  GameHomeViewModel.swift
//  GamerSky
//
//  Created by Insect on 2018/7/4.
//  Copyright © 2018年 engic. All rights reserved.
//

import Foundation
import RxDataSources

class GameHomeViewModel: RefreshViewModel {

    private let vmDatas = Variable<[GameHomeSection]>([])
    
    struct GameHomeInput {}
    
    struct GameHomeOutput {

        let sections: Driver<[GameHomeSection]>
    }
}

extension GameHomeViewModel: ViewModelable {

    func transform(input: GameHomeViewModel.GameHomeInput) -> GameHomeViewModel.GameHomeOutput {

        let temp_sections = vmDatas.asObservable().map { (sections) -> [GameHomeSection] in
            return sections.map { (item) -> GameHomeSection in
                return item
            }
        }
        .asDriver(onErrorJustReturn: [])

        let output = GameHomeOutput(sections: temp_sections)

        guard let refresh = unified else { return output }

        let loadNew = refresh.header
        .asDriver()
        .flatMapLatest { _ -> SharedSequence<DriverSharingStrategy, (GameHomeSection, GameHomeSection, GameHomeSection, GameHomeSection, [Array<GameInfo>], [Array<GameInfo>], GameHomeSection, GameHomeSection)> in
            
            // sectionHeader 数据
            let data = try! Data(contentsOf: Bundle.main.url(forResource: "GameHomeSectionData", withExtension: "plist")!)
            let sectionData = try! PropertyListDecoder().decode([GameHomeSectionModel].self, from: data)
            
            // 新游推荐
            let symbol1 = GameApi.gameSpecialDetail(1, 13)
            .cache
            .request()
            .mapObject([GameInfo].self)
            .asDriver(onErrorJustReturn: [])
            .map { GameHomeSection.specialDetailSection([GameHomeItem.specialDetailItem($0)]) }
            
            // 最近大家都在玩
            let symbol2 = GameApi.gameHomePage(1, .hot)
            .cache
            .request()
            .mapObject([GameInfo].self)
            .asDriver(onErrorJustReturn: [])
            .map { GameHomeSection.hotSection([GameHomeItem.hotItem($0, sectionData)]) }
            
            // 特色专题
            let symbol3 = GameApi.gameSpecialList(1)
            .cache
            .request()
            .mapObject([GameSpecialList].self)
            .asDriver(onErrorJustReturn: [])
            .map { GameHomeSection.specialListSection([GameHomeItem.specialListItem($0)]) }
            
            // 即将发售
            let symbol4 = GameApi.gameHomePage(1, .waitSell)
            .cache
            .request()
            .mapObject([GameInfo].self)
            .asDriver(onErrorJustReturn: [])
            .map { GameHomeSection.waitSellSection([GameHomeItem.waitSellItem($0, sectionData)]) }
            
            // 高分榜
            let symbol5 = GameApi.gameRankingList(1, .fractions, 0, "all")
            .cache
            .request()
            .mapObject([GameInfo].self)
            .asDriver(onErrorJustReturn: [])
            .map { [Array($0.prefix(5))] }
            
            // 热门榜
            let symbol6 = GameApi.gameRankingList(1, .hot, 0, "all")
            .cache
            .request()
            .mapObject([GameInfo].self)
            .asDriver(onErrorJustReturn: [])
            .map { [Array($0.prefix(5))] }
            
            // 最期待游戏
            let symbol7 = GameApi.gameHomePage(1, .expected)
            .cache
            .request()
            .mapObject([GameInfo].self)
            .asDriver(onErrorJustReturn: [])
            .map { GameHomeSection.expectedSection([GameHomeItem.expectedItem($0, sectionData)]) }
            
            // 找游戏
            let symbol8 = GameApi.gameTags
            .cache
            .request()
            .mapObject([GameTag].self)
            .asDriver(onErrorJustReturn: [])
            .map({GameHomeSection.tagSection([GameHomeItem.tagItem($0)])})

            return Driver.zip(symbol1, symbol2, symbol3, symbol4, symbol5, symbol6, symbol7, symbol8)
        }
        
        loadNew.drive(onNext: { (symbol1Data, symbol2Data, symbol3Data, symbol4Data, symbol5Data, symbol6Data,symbol7Data,symbol8Data) in
            
            var rankingGame = symbol5Data
            rankingGame += symbol6Data
            let rankingSection = GameHomeSection
            .rankingSection([GameHomeItem.rankingItem(rankingGame)])
            
            var sectionModels: ([GameHomeSection]) = []
            sectionModels.append(symbol1Data)
            sectionModels.append(symbol2Data)
            sectionModels.append(symbol3Data)
            sectionModels.append(symbol4Data)
            sectionModels.append(rankingSection)
            sectionModels.append(symbol7Data)
            self.vmDatas.value = sectionModels

        })
        .disposed(by: disposeBag)

        // 头部刷新状态
        loadNew
        .map { _ in false }
        .drive(headerRefreshState)
        .disposed(by: disposeBag)
        
        return output
    }
}

enum GameHomeSection {
    
    /// 新游推荐
    case specialDetailSection([GameHomeItem])
    /// 最近大家都在玩
    case hotSection([GameHomeItem])
    /// 特色专题
    case specialListSection([GameHomeItem])
    /// 即将发售
    case waitSellSection([GameHomeItem])
    /// 排行榜
    case rankingSection([GameHomeItem])
    /// 最期待游戏
    case expectedSection([GameHomeItem])
    // 找游戏
    case tagSection([GameHomeItem])
}

enum GameHomeItem {
    
    /// 新游推荐
    case specialDetailItem([GameInfo])
    /// 最近大家都在玩
    case hotItem([GameInfo], [GameHomeSectionModel])
    /// 特色专题
    case specialListItem([GameSpecialList])
    /// 即将发售
    case waitSellItem([GameInfo], [GameHomeSectionModel])
    /// 排行榜
    case rankingItem([[GameInfo]])
    /// 最期待游戏
    case expectedItem([GameInfo], [GameHomeSectionModel])
    // 找游戏
    case tagItem([GameTag])
}

extension GameHomeSection: SectionModelType {
    
    typealias Item = GameHomeItem
    
    var items: [GameHomeItem] {
        switch self {
        case let .specialDetailSection(rows):
            return rows
        case let .hotSection(rows):
            return rows
        case let .specialListSection(rows):
            return rows
        case let .waitSellSection(rows):
            return rows
        case let .rankingSection(rows):
            return rows
        case let .expectedSection(rows):
            return rows
        case let .tagSection(rows):
            return rows
        }
    }
    
    init(original: GameHomeSection, items: [Item]) {

        switch original {

        case .specialDetailSection:
            self = .specialDetailSection(items)
        case .hotSection:
            self = .hotSection(items)
        case .specialListSection:
            self = .specialListSection(items)
        case .waitSellSection:
            self = .waitSellSection(items)
        case .rankingSection:
            self = .rankingSection(items)
        case .expectedSection:
            self = .expectedSection(items)
        case .tagSection:
            self = .tagSection(items)
        }
    }
}
