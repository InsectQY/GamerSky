//
//  GameHomePageFlowLayout.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/14.
//Copyright © 2018年 engic. All rights reserved.
//

import UIKit

class GameHomePageFlowLayout: UICollectionViewFlowLayout {
    
    /// 左右间距
    static let kEdge: CGFloat = 10
    /// cell 之间间距
    private let kItemMargin: CGFloat = 15
    /// 每行最大列数
    private let kMaxCol: CGFloat = 4
    /// cell 宽度
    private var kItemW: CGFloat {
        return (ScreenWidth - (2 * GameHomePageFlowLayout.kEdge) - ((kMaxCol - 1) * kItemMargin)) / kMaxCol
    }
    
    override func prepare() {
        super.prepare()
        
        itemSize = CGSize(width: kItemW, height: GameHomeHotContentCell.cellHeight)
        footerReferenceSize = CGSize(width: kItemW, height: GameHomeHotContentCell.cellHeight)
        sectionInset = UIEdgeInsetsMake(0, 0, 0, kItemMargin)
        minimumInteritemSpacing = kItemMargin
    }
}
