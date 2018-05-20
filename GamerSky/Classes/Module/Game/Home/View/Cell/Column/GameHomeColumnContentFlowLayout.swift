//
//  GameHomeColumnContentFlowLayout.swift
//  GamerSky
//
//  Created by InsectQY on 2018/5/6.
//Copyright © 2018年 QY. All rights reserved.
//

import UIKit

class GameHomeColumnContentFlowLayout: UICollectionViewFlowLayout {
    
    /// cell 之间间距
    private static let kItemMargin: CGFloat = 10
    /// 左右间距
    public static let kEdge: CGFloat = 10
    /// 每行最大列数
    private static let kMaxCol: CGFloat = 2
    /// cell 宽度
    public static var kItemW: CGFloat {
        return (ScreenWidth - (2 * kEdge) - ((kMaxCol - 1) * kItemMargin)) / kMaxCol
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        itemSize = CGSize(width: GameHomeColumnContentFlowLayout.kItemW, height: GameHomeColumnContentCell.cellHeight)
        sectionInset = UIEdgeInsetsMake(0, 0, 0, GameHomeColumnContentFlowLayout.kEdge)
        minimumLineSpacing = GameHomeColumnContentFlowLayout.kItemMargin
        footerReferenceSize = CGSize(width: GameHomeWaitSellContentCell.kItemW, height: GameHomeColumnContentCell.cellHeight)
    }
}
