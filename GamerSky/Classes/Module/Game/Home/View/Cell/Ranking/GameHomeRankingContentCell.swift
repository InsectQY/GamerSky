//
//  GameHomeRankingContentCell.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/10.
//Copyright © 2018年 engic. All rights reserved.
//

import UIKit

class GameHomeRankingContentCell: UITableViewCell, NibReusable {

    static let cellHeight: CGFloat = 370
    
    /// cell 高度
    private let kItemH: CGFloat = 60
    
    // MARK: - public
    public var rankingGame = [[GameInfo]]()  {
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
        
        flowLayout.itemSize = CGSize(width: ScreenWidth, height: kItemH)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        collectionView.register(cellType: GameHomeRankingCell.self)
    }
}

// MARK: - UICollectionViewDataSource
extension GameHomeRankingContentCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return rankingGame.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rankingGame[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: GameHomeRankingCell.self)
        cell.tag = indexPath.row
        cell.info = rankingGame[indexPath.section][indexPath.row]
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension GameHomeRankingContentCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
