//
//  GameHomeWaitSellContentCell.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/10.
//Copyright © 2018年 engic. All rights reserved.
//

import UIKit

class GameHomeWaitSellContentCell: UITableViewCell, NibReusable {

    static let waitSellingHeight: CGFloat = ScreenHeight * 0.3
    static let hotHeight: CGFloat = ScreenHeight * 0.25
    
    /// 左右间距
    private let kEdge: CGFloat = 10
    /// cell 之间间距
    private let kItemMargin: CGFloat = 15
    /// 每行最大列数
    private let kMaxCol: CGFloat = 4
    /// cell 宽度
    public var kItemW: CGFloat {
        return (ScreenWidth - (2 * kEdge) - ((kMaxCol - 1) * kItemMargin)) / kMaxCol
    }

    // MARK: - IBOutlet
    @IBOutlet private weak var monthContentView: UIView!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet private weak var monthLabel: BaseLabel!
    @IBOutlet private weak var collectionViewTopConstraints: NSLayoutConstraint!
    @IBOutlet private weak var collectionViewTopConstraint: NSLayoutConstraint!
    
    // MARK: - public
    public var sectionType: GameHomeSectionType? {
        
        didSet {
            monthContentView.isHidden = sectionType != .waitSelling
            if sectionType != .waitSelling {
                collectionViewTopConstraint.priority = UILayoutPriority(rawValue: 1)
            }else {
                collectionViewTopConstraint.priority = UILayoutPriority(rawValue: 999)
            }
        }
    }
    
    /// 按月份分割好的数组
    private var monthGame = [[GameInfo]]()
    
    public var game = [GameInfo]() {
        
        didSet {
            
            if sectionType == .waitSelling {
               
                monthGame.removeAll()
                // 按12个月分割数组
                (1...12).forEach { num in
                    
                    let result = game.filter {$0.month == "\(num)"}
                    if result.count > 0 {monthGame.append(result)}
                }
            }
            
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
        
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, kItemMargin)
        flowLayout.minimumLineSpacing = kItemMargin
        collectionView.contentInset = UIEdgeInsetsMake(0, kEdge, 0, kEdge)
        collectionView.register(cellType: GameHomePageCell.self)
        collectionView.register(supplementaryViewType: GameHomePageFooterView.self, ofKind: UICollectionElementKindSectionFooter)
        flowLayout.footerReferenceSize = CGSize(width: kItemW, height: 200)
    }
}

// MARK: - UICollectionViewDataSource
extension GameHomeWaitSellContentCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionType == .waitSelling ? monthGame.count : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionType == .waitSelling ? monthGame[section].count : game.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: GameHomePageCell.self)
        cell.tag = indexPath.row
        cell.sectionType = sectionType
        let info = sectionType == .waitSelling ? monthGame[indexPath.section][indexPath.row] : game[indexPath.row]
        cell.info = info
        return cell
    }
}

// MARK: - UIScrollViewDelegate
extension GameHomeWaitSellContentCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard sectionType == .waitSelling, let indexPath = collectionView.indexPathForItem(at: scrollView.contentOffset) else {return}
        monthLabel.text = "\(monthGame[indexPath.section][0].month ?? "")月"
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension GameHomeWaitSellContentCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return sectionType == .waitSelling ? CGSize(width: kItemW, height: GameHomeWaitSellContentCell.waitSellingHeight + 20) : CGSize(width: kItemW, height: GameHomeWaitSellContentCell.hotHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {

        if sectionType == .waitSelling {
            return section == monthGame.count - 1 ? CGSize(width: kItemW, height: GameHomeWaitSellContentCell.waitSellingHeight) : .zero
        }else {
            return CGSize(width: kItemW, height: 1)
        }
    }
}

// MARK: - UICollectionViewDelegate
extension GameHomeWaitSellContentCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, for: indexPath, viewType: GameHomePageFooterView.self)
        return footer
    }
}
