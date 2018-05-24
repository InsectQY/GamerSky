//
//  ColumnHeaderFlowLayout.swift
//  GamerSky
//
//  Created by InsectQY on 2018/5/6.
//Copyright © 2018年 QY. All rights reserved.
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
    public var kColumnListCellW: CGFloat {
        return (ScreenWidth - (2 * kEdge) - ((kMaxCol - 1) * kItemMargin)) / kMaxCol
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        itemSize = CGSize(width: kColumnListCellW, height: kColumnListCellW)
        minimumLineSpacing = kItemMargin
        minimumInteritemSpacing = 0
        sectionInset = UIEdgeInsetsMake(0, kEdge, 0, kEdge)
    }
}
