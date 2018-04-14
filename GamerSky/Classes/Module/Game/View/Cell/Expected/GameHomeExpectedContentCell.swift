//
//  GameHomeExpectedContentCell.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/10.
//Copyright © 2018年 engic. All rights reserved.
//

import UIKit

class GameHomeExpectedContentCell: UITableViewCell, NibReusable {

    static let cellHeight: CGFloat = ScreenHeight * 0.25
    
    // MARK: - IBOutlet
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var flowLayout: GameHomePageFlowLayout!
    
    // MARK: - public
    public var sectionHeader: GameHomeSection?
    
    public var expectedGame = [GameInfo]() {
        
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: - inital
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpCollectionView()
    }
    
    // MARK: - setUpCollectionView
    private func setUpCollectionView() {
        
        collectionView.contentInset = UIEdgeInsetsMake(0, GameHomePageFlowLayout.kEdge, 0, GameHomePageFlowLayout.kEdge)
        collectionView.register(cellType: GameHomePageCell.self)
        collectionView.register(supplementaryViewType: GameHomePageFooterView.self, ofKind: UICollectionElementKindSectionFooter)
    }
}

// MARK: - UICollectionViewDataSource
extension GameHomeExpectedContentCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return expectedGame.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: GameHomePageCell.self)
        cell.sectionType = sectionHeader?.sectionType
        cell.info = expectedGame[indexPath.item]
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension GameHomeExpectedContentCell: UICollectionViewDelegate {
        
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, for: indexPath, viewType: GameHomePageFooterView.self)
        return footer
    }
}
