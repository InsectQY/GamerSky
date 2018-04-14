//
//  GameRankingFlowLayout.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/14.
//Copyright © 2018年 engic. All rights reserved.
//

import UIKit

class GameRankingFlowLayout: UICollectionViewFlowLayout {

    /// cell 之间间距
    private let kItemMargin: CGFloat = 10
    /// 左右间距
    private let kEdge: CGFloat = 10
    /// cell 宽度
    private let kItemW: CGFloat = ScreenWidth * 0.8
    /// cell 高度
    private let kItemH: CGFloat = 60
    
    override func prepare() {
        super.prepare()
        
        itemSize = CGSize(width: kItemW, height: kItemH)
        sectionInset = UIEdgeInsetsMake(0, kEdge, 0, kEdge)
        minimumLineSpacing = kItemMargin
        minimumInteritemSpacing = kItemMargin
    }
}
