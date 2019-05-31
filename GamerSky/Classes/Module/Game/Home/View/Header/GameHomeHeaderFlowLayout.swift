//
//  GameHomeHeaderFlowLayout.swift
//  GamerSky
//
//  Created by QY on 2018/5/3.
//  Copyright © 2018年 QY. All rights reserved.
//

import UIKit

class GameHomeHeaderFlowLayout: UICollectionViewFlowLayout {

    /// cell 之间间距
    private let kItemMargin: CGFloat = 25
    /// 左右间距
    private let kEdge: CGFloat = 10
    /// 每行最大列数
    private let kMaxCol: CGFloat = 5
    /// cell 宽度
    private var kItemW: CGFloat {
        return (Configs.Dimensions.screenWidth - (2 * kEdge) - ((kMaxCol - 1) * kItemMargin)) / kMaxCol
    }
    
    override init() {
        super.init()
        
        itemSize = CGSize(width: kItemW, height: GameHomeHeaderView.height)
        sectionInset = UIEdgeInsets.init(top: 0, left: kEdge, bottom: 0, right: kEdge)
        minimumLineSpacing = kItemMargin
        minimumInteritemSpacing = kItemMargin
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
