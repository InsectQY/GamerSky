//
//  GameColumnFlowLayout.swift
//  GamerSky
//
//  Created by QY on 2018/5/2.
//  Copyright © 2018年 QY. All rights reserved.
//

import UIKit

class GameColumnFlowLayout: UICollectionViewFlowLayout {

    /// cell 之间间距
    private let kItemMargin: CGFloat = 15
    /// 左右间距
    private let kEdge: CGFloat = 15
    /// 每行最大列数
    private let kMaxCol: CGFloat = 1
    /// cell 宽度
    private var kItemW: CGFloat {
        return (ScreenWidth - (2 * kEdge) - ((kMaxCol - 1) * kItemMargin)) / kMaxCol
    }
    /// cell 高度
    private var kItemH: CGFloat {
        return kItemW * 0.4
    }
    
    override init() {
        
        super.init()
        
        itemSize = CGSize(width: kItemW, height: kItemH)
        scrollDirection = .vertical
        minimumInteritemSpacing = kEdge
        minimumLineSpacing = kItemMargin
        sectionInset = UIEdgeInsets.init(top: kItemMargin, left: 0, bottom: kItemMargin, right: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
