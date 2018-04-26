//
//  GameHomeColumnContentCell.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/10.
//Copyright © 2018年 engic. All rights reserved.
//

import UIKit

class GameHomeColumnContentCell: UITableViewCell, NibReusable {

    public static let cellHeight: CGFloat = kItemW * 0.75
    
    /// cell 之间间距
    private static let kItemMargin: CGFloat = 10
    /// 左右间距
    private static let kEdge: CGFloat = 10
    /// 每行最大列数
    private static let kMaxCol: CGFloat = 2
    /// cell 宽度
    private static var kItemW: CGFloat {
        return (ScreenWidth - (2 * kEdge) - ((kMaxCol - 1) * kItemMargin)) / kMaxCol
    }
    
    // MARK: - public
    public var columnGame = [GameSpecialList]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: - IBOutlet
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var flowLayout: UICollectionViewFlowLayout!
    
    // MARK: - inital
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
    }
    
    // MARK: - setUpCollectionView
    private func setUpCollectionView() {
        
        flowLayout.itemSize = CGSize(width: GameHomeColumnContentCell.kItemW, height: GameHomeColumnContentCell.cellHeight)
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, GameHomeColumnContentCell.kEdge)
        flowLayout.minimumLineSpacing = GameHomeColumnContentCell.kItemMargin
        flowLayout.footerReferenceSize = CGSize(width: GameHomeWaitSellContentCell.kItemW, height: GameHomeColumnContentCell.cellHeight)
        collectionView.contentInset = UIEdgeInsetsMake(0, GameHomeColumnContentCell.kEdge, 0, GameHomeColumnContentCell.kEdge)
        collectionView.register(cellType: GameHomeColumnCell.self)
        collectionView.register(supplementaryViewType: GameRecommendFooterView.self, ofKind: UICollectionElementKindSectionFooter)
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
