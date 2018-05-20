//
//  GameHomeColumnContentCell.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/10.
//Copyright © 2018年 QY. All rights reserved.
//

import UIKit

class GameHomeColumnContentCell: BaseTableViewCell, NibReusable {

    public static let cellHeight: CGFloat = GameHomeColumnContentFlowLayout.kItemW * 0.75
    
    // MARK: - public
    public var columnGame = [GameSpecialList]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: - IBOutlet
    @IBOutlet private weak var flowLayout: GameHomeColumnContentFlowLayout!
    @IBOutlet private weak var collectionView: BaseCollectionView! {
        
        didSet {
            
            collectionView.contentInset = UIEdgeInsetsMake(0, GameHomeColumnContentFlowLayout.kEdge, 0, GameHomeColumnContentFlowLayout.kEdge)
            collectionView.register(cellType: GameHomeColumnCell.self)
            collectionView.register(supplementaryViewType: GameRecommendFooterView.self, ofKind: UICollectionElementKindSectionFooter)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension GameHomeColumnContentCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return columnGame.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: GameHomeColumnCell.self)
        cell.column = columnGame[indexPath.item]
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension GameHomeColumnContentCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, for: indexPath, viewType: GameRecommendFooterView.self)
        footer.cornerRadius = 3
        return footer
    }
}
