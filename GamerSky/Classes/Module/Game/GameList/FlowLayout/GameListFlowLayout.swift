//
//  GameListFlowLayout.swift
//  GamerSky
//
//  Created by engic on 2018/4/26.
//  Copyright © 2018年 engic. All rights reserved.
//

import UIKit

class GameListFlowLayout: UICollectionViewFlowLayout {

    /// 左右间距
    private let kEdge: CGFloat = 15
    /// cell 上下间距
    private let kLineSpacing: CGFloat = 15
    /// cell 左右间距
    private let kInteritemSpacing: CGFloat = 30
    /// 每行最大列数
    private let kMaxCol: CGFloat = 3
    /// cell 宽度
    private var kItemW: CGFloat {
        return (ScreenWidth - (2 * kEdge) - ((kMaxCol - 1) * kInteritemSpacing)) / kMaxCol
    }
    private var kItemH: CGFloat {
        return kItemW * 1.8
    }
    
    override init() {
        super.init()
        
        itemSize = CGSize(width: kItemW, height: kItemH)
        sectionInset = UIEdgeInsetsMake(0, kEdge, 0, kEdge)
        minimumLineSpacing = kLineSpacing
        minimumInteritemSpacing = kInteritemSpacing
        headerReferenceSize = CGSize(width: ScreenWidth, height: GameListHeaderView.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
