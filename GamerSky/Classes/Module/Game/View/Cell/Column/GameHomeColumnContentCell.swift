//
//  GameHomeColumnContentCell.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/10.
//Copyright © 2018年 engic. All rights reserved.
//

import UIKit

class GameHomeColumnContentCell: UITableViewCell, NibReusable {

    static let cellHeight: CGFloat = ScreenHeight * 0.2
    
    // MARK: - public
    public var columnGame = [GameSpecialList]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: - IBOutlet
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var flowLayout: GameHomeColumnFlowLayout!
    
    // MARK: - inital
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
    }
    
    // MARK: - setUpCollectionView
    private func setUpCollectionView() {
        
        collectionView.register(cellType: GameHomeColumnCell.self)
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
