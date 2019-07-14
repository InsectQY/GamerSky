//
//  GameHomeColumnCell.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/10.
//Copyright © 2018年 QY. All rights reserved.
//

import UIKit

class GameHomeColumnCell: CollectionViewCell, NibReusable {

    /// 是否加载大图
    public var isLoadBigImage: Bool = false
    // MARK: - IBOutlet
    @IBOutlet private weak var columnImageView: UIImageView!
    
    // MARK: - public
    public var column: GameSpecialList? {
        didSet {
            
            let image = isLoadBigImage ? column?.image : column?.smallImage
            columnImageView.qy_setImage(image)
        }
    }
}
