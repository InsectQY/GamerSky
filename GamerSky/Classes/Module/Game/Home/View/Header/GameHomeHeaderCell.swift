//
//  GameHomeHeaderCell.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/9.
//Copyright © 2018年 QY. All rights reserved.
//

import UIKit

class GameHomeHeaderCell: BaseCollectionViewCell, NibReusable {

    // MARK: - IBOutlet
    @IBOutlet private weak var titleLabel: BaseLabel!
    @IBOutlet private weak var imageView: UIImageView!
    
    // MARK: - public
    public var header: GameHomeHeader? {
        
        didSet {
            
            titleLabel.text = header?.title
            imageView.image = UIImage(named: header?.image ?? "")
        }
    }
}
