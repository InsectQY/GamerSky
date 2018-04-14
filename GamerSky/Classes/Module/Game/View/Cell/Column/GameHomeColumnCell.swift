//
//  GameHomeColumnCell.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/10.
//Copyright © 2018年 engic. All rights reserved.
//

import UIKit

class GameHomeColumnCell: UICollectionViewCell, NibReusable {

    // MARK: - IBOutlet
    @IBOutlet private weak var columnImageView: UIImageView!
    
    // MARK: - public
    public var column: GameSpecialList? {
        didSet {
            columnImageView.qy_setImage(column?.smallImage, "")
        }
    }
}
