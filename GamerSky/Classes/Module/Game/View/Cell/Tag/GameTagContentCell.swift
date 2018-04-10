//
//  GameTagContentCell.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/10.
//Copyright © 2018年 engic. All rights reserved.
//

import UIKit

/// cell 之间间距
private let kItemMargin: CGFloat = 5
/// 左右间距
private let kEdge: CGFloat = 10

class GameTagContentCell: UITableViewCell, NibReusable {

    static let cellHeight: CGFloat = 140
    
    public var gameTag = [GameTag]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var flowLayout: UICollectionViewFlowLayout!

    // MARK: - inital
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
    }
    
    // MARK: - setUpCollectionView
    private func setUpCollectionView() {
        
        flowLayout.sectionInset = UIEdgeInsetsMake(0, kEdge, 0, kEdge)
        flowLayout.minimumLineSpacing = kItemMargin
        flowLayout.minimumInteritemSpacing = kItemMargin
        collectionView.register(cellType: GameHomeTagCell.self)
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameTag.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: GameHomeTagCell.self)
        cell.gameTag = gameTag[indexPath.item]
        return cell
    }
}

