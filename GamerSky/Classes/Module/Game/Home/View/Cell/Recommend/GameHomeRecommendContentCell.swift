//
//  GameHomeRecommendContentCell.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/9.
//Copyright © 2018年 QY. All rights reserved.
//

import UIKit

class GameHomeRecommendContentCell: TableViewCell, NibReusable {
    
    static let cellHeight: CGFloat = Configs.Dimensions.screenHeight * 0.28
    
    //分页序号
    private var selectedIndex: CGFloat = 0
    /// cell 之间间距
    private let kItemMargin: CGFloat = 5
    /// 左右间距
    private let kEdge: CGFloat = 10
    /// 每行最大列数
    private let kMaxCol: CGFloat = 1
    /// 每行最大列数
    private let kFooterWidth: CGFloat = Configs.Dimensions.screenWidth * 0.25
    /// cell 宽度
    private var kItemW: CGFloat {
        return (Configs.Dimensions.screenWidth - (2 * kEdge) - ((kMaxCol - 1) * kItemMargin)) / kMaxCol
    }
    
    // MARK: - public
    public var gameSpecialDetail = [GameInfo]() {
        
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: - IBOutlet
    @IBOutlet private weak var collectionView: CollectionView!
    @IBOutlet private weak var flowLayout: UICollectionViewFlowLayout!
    
    // MARK: - inital
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpCollectionView()
    }
    
    // MARK: - setUpCollectionView
    private func setUpCollectionView() {
        
        flowLayout.itemSize = CGSize(width: kItemW, height: GameHomeRecommendContentCell.cellHeight)
        flowLayout.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: kItemMargin)
        flowLayout.minimumLineSpacing = kItemMargin
        flowLayout.footerReferenceSize = CGSize(width: kFooterWidth, height: GameHomeRecommendContentCell.cellHeight)
        collectionView.contentInset = UIEdgeInsets.init(top: 0, left: kEdge, bottom: 0, right: kEdge)
        collectionView.register(cellType: GameHomeRecommendCell.self)
        collectionView.register(supplementaryViewType: GameRecommendFooterView.self, ofKind: UICollectionView.elementKindSectionFooter)
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
        
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, for: indexPath, viewType: GameRecommendFooterView.self)
        return footer
    }
}

// MARK: - UIScrollViewDelegate
extension GameHomeRecommendContentCell: UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let x = targetContentOffset.pointee.x
        let pageWidth = kItemW + kItemMargin
        let movedX = x - pageWidth * selectedIndex
        if movedX < -kFooterWidth {
            selectedIndex -= 1
        } else if movedX > kFooterWidth {
            selectedIndex += 1
        }
        if abs(velocity.x) >= 2 {
            targetContentOffset.pointee.x = pageWidth * selectedIndex - kEdge
        } else {
            targetContentOffset.pointee.x = scrollView.contentOffset.x
            scrollView.setContentOffset(CGPoint(x: pageWidth * selectedIndex - kEdge, y: scrollView.contentOffset.y), animated: true)
        }
    }
}
