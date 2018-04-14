//
//  GameHomeRecommendContentCell.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/9.
//Copyright © 2018年 engic. All rights reserved.
//

import UIKit

class GameHomeRecommendContentCell: UITableViewCell, NibReusable {
    
    static let cellHeight: CGFloat = ScreenHeight * 0.28
    
    /// cell 之间间距
    private let kItemMargin: CGFloat = 5
    /// 左右间距
    private let kEdge: CGFloat = 10
    /// 每行最大列数
    private let kMaxCol: CGFloat = 1
    /// cell 宽度
    private var kItemW: CGFloat {
        return (ScreenWidth - (2 * kEdge) - ((kMaxCol - 1) * kItemMargin)) / kMaxCol
    }
    
    // MARK: - public
    public var gameSpecialDetail = [GameInfo]() {
        
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
        
        flowLayout.itemSize = CGSize(width: kItemW, height: GameHomeRecommendContentCell.cellHeight)
        flowLayout.sectionInset = UIEdgeInsetsMake(0, kEdge, 0, kEdge)
        flowLayout.minimumLineSpacing = kItemMargin
        collectionView.register(cellType: GameHomeRecommendCell.self)
    }
}

// MARK: - UICollectionViewDataSource
extension GameHomeRecommendContentCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameSpecialDetail.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: GameHomeRecommendCell.self)
        cell.detail = gameSpecialDetail[indexPath.item]
        return cell
    }
}
