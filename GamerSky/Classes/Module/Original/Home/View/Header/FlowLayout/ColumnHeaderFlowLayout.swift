//
//  ColumnHeaderFlowLayout.swift
//  GamerSky
//
//  Created by InsectQY on 2018/5/6.
//Copyright © 2018年 engic. All rights reserved.
//

import UIKit

class ColumnHeaderFlowLayout: UICollectionViewFlowLayout {
    
    /// cell 之间间距
    private let kItemMargin: CGFloat = 15
    /// 左右间距
    private let kEdge: CGFloat = 10
    /// 每行最大列数
    private let kMaxCol: CGFloat = 4
    /// cell 宽度
    private var kColumnListCellW: CGFloat {
        return (ScreenWidth - (2 * kEdge) - ((kMaxCol - 1) * kItemMargin)) / kMaxCol
    }
    /// cell 高度
    private let kItemH: CGFloat = 90
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        itemSize = CGSize(width: kColumnListCellW, height: kItemH)
        minimumLineSpacing = 0
        minimumInteritemSpacing = kItemMargin
        sectionInset = UIEdgeInsetsMake(0, kEdge, 0, kEdge)
    }
}
