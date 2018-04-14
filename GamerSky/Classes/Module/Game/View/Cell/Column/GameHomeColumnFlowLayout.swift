//
//  GameHomeColumnFlowLayout.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/14.
//Copyright © 2018年 engic. All rights reserved.
//

import UIKit

class GameHomeColumnFlowLayout: UICollectionViewFlowLayout {

    /// cell 之间间距
    private let kItemMargin: CGFloat = 10
    /// 左右间距
    private let kEdge: CGFloat = 10
    /// 每行最大列数
    private let kMaxCol: CGFloat = 2
    /// cell 宽度
    private var kItemW: CGFloat {
        return (ScreenWidth - (2 * kEdge) - ((kMaxCol - 1) * kItemMargin)) / kMaxCol
    }
    
    // MARK: - prepare
    override func prepare() {
        super.prepare()
        
        scrollDirection = .horizontal
        itemSize = CGSize(width: kItemW, height: GameHomeColumnContentCell.cellHeight)
        sectionInset = UIEdgeInsetsMake(0, kEdge, 0, kEdge)
        minimumLineSpacing = kItemMargin
    }
}
