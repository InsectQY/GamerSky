//
//  GameHomeTagCell.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/10.
//Copyright © 2018年 QY. All rights reserved.
//

import UIKit

class GameHomeTagCell: BaseCollectionViewCell, NibReusable {

    static let cellHeight: CGFloat = 30
    
    // MARK: - IBOutlet
    @IBOutlet private weak var gameTagLabel: UILabel!
    
    // MARK: - public
    public var gameTag: GameTag? {
        
        didSet {
            gameTagLabel.text = gameTag?.name
        }
    }
    
    // MARK: - inital
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cornerRadius = width * 0.1
    }
}
