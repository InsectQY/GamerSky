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
    
    //分页序号
    private var selectedIndex: Int = 0
    /// cell 之间间距
    private let kItemMargin: CGFloat = 5
    /// 左右间距
    private let kEdge: CGFloat = 10
    /// 每行最大列数
    private let kMaxCol: CGFloat = 1
    /// 每行最大列数
    private let kFooterWidth: CGFloat = ScreenWidth * 0.25
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
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, kItemMargin)
        flowLayout.minimumLineSpacing = kItemMargin
        flowLayout.footerReferenceSize = CGSize(width: kFooterWidth, height: GameHomeRecommendContentCell.cellHeight)
        collectionView.contentInset = UIEdgeInsetsMake(0, kEdge, 0, kEdge)
        collectionView.register(cellType: GameHomeRecommendCell.self)
        collectionView.register(supplementaryViewType: GameRecommendFooterView.self, ofKind: UICollectionElementKindSectionFooter)
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

// MARK: - UICollectionViewDelegate
extension GameHomeRecommendContentCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, for: indexPath, viewType: GameRecommendFooterView.self)
        return footer
    }
}

// MARK: - UIScrollViewDelegate
extension GameHomeRecommendContentCell: UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let x = targetContentOffset.pointee.x
        let pageWidth = kItemW + kItemMargin
        let movedX = x - pageWidth * CGFloat(selectedIndex)
        if movedX < -kFooterWidth {
            // Move left
            selectedIndex -= 1
        } else if movedX > kFooterWidth {
            // Move right
            selectedIndex += 1
        }
        if abs(velocity.x) >= 2 {
            targetContentOffset.pointee.x = pageWidth * CGFloat(selectedIndex) - kEdge
        } else {
            targetContentOffset.pointee.x = scrollView.contentOffset.x
            scrollView.setContentOffset(CGPoint(x: pageWidth * CGFloat(selectedIndex) - kEdge, y: scrollView.contentOffset.y), animated: true)
        }
    }
}
