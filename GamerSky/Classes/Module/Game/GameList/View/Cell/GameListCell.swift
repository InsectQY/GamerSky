//
//  GameListCell.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/23.
//Copyright © 2018年 QY. All rights reserved.
//

import UIKit

class GameListCell: BaseCollectionViewCell, NibReusable {

    // MARK: - IBOutlet
    @IBOutlet private weak var gameImageView: UIImageView!
    @IBOutlet private weak var ratingView: CosmosView!
    @IBOutlet private weak var gameScoreLabel: BaseLabel!
    @IBOutlet private weak var gameNameLabel: BaseLabel!
    
    public var info: GameChildElement? {
        
        didSet {
            
            guard let info = info else {return}
            
            gameImageView.qy_setImage(info.image, "")
            gameNameLabel.text = info.title
        }
    }
    
    // MARK: - prepareForReuse
    override func prepareForReuse() {
        ratingView.prepareForReuse()
    }
}
