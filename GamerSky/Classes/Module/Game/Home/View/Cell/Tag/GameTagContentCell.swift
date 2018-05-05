//
//  GameTagContentCell.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/10.
//Copyright © 2018年 engic. All rights reserved.
//

import UIKit

class GameTagContentCell: BaseTableViewCell, NibReusable {

    static let cellHeight: CGFloat = 60
    
    // MARK: - public
    public var gameTag = [GameTag]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: - IBOutlet
    @IBOutlet private weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet private weak var collectionView: BaseCollectionView! {
        didSet {
            collectionView.register(cellType: GameHomeTagCell.self)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension GameTagContentCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: GameHomeTagCell.cellHeight)
    }
}

// MARK: - UICollectionViewDataSource
extension GameTagContentCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameTag.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: GameHomeTagCell.self)
        cell.gameTag = gameTag[indexPath.item]
        return cell
    }
}
