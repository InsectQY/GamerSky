//
//  GameHomeWaitSellContentCell.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/10.
//Copyright © 2018年 engic. All rights reserved.
//

import UIKit

/// cell 之间间距
private let kItemMargin: CGFloat = 15
/// 左右间距
private let kEdge: CGFloat = 10
/// 每行最大列数
private let kMaxCol: CGFloat = 4
/// cell 宽度
private let kItemW = (ScreenWidth - (2 * kEdge) - ((kMaxCol - 1) * kItemMargin)) / kMaxCol

class GameHomeWaitSellContentCell: UITableViewCell, NibReusable {

    static let cellHeight: CGFloat = ScreenHeight * 0.3
    
    // MARK: - IBOutlet
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var flowLayout: UICollectionViewFlowLayout!
    
    // MARK: - public
    public var sectionHeader: GameHomeSection?
    
    public var waitSellGame = [GameInfo]() {
        
        didSet {
            
            allWaitSellGame.removeAll()
            // 按12个月分割数组
            (1...12).forEach { num in
                
                let result = waitSellGame.filter {$0.month == "\(num)"}
                if result.count > 0 {allWaitSellGame.append(result)}
            }
            collectionView.reloadData()
        }
    }
    
    /// 按月份分割好的数组
    private var allWaitSellGame = [[GameInfo]]()

    // MARK: - inital
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpCollectionView()
    }
    
    // MARK: - setUpCollectionView
    private func setUpCollectionView() {
        
        flowLayout.itemSize = CGSize(width: kItemW, height: GameHomeWaitSellContentCell.cellHeight + 20)
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, kItemMargin)
        collectionView.contentInset = UIEdgeInsetsMake(0, kEdge, 0, kEdge)
        flowLayout.minimumLineSpacing = kItemMargin
        flowLayout.minimumInteritemSpacing = 0
        collectionView.register(cellType: GameHomePageCell.self)
        collectionView.register(supplementaryViewType: GameHomePageFooterView.self, ofKind: UICollectionElementKindSectionFooter)
    }
}

// MARK: - UICollectionViewDataSource
extension GameHomeWaitSellContentCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return allWaitSellGame.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allWaitSellGame[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: GameHomePageCell.self)
        cell.tag = indexPath.row
        cell.sectionType = sectionHeader?.sectionType
        cell.info = allWaitSellGame[indexPath.section][indexPath.row]
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension GameHomeWaitSellContentCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return section == allWaitSellGame.count - 1 ? CGSize(width: kItemW, height: GameHomeWaitSellContentCell.cellHeight) : .zero
    }
}

// MARK: - UICollectionViewDelegate
extension GameHomeWaitSellContentCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, for: indexPath, viewType: GameHomePageFooterView.self)
        return footer
    }
}
