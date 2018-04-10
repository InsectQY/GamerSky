//
//  GameHomePageCell.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/10.
//Copyright © 2018年 engic. All rights reserved.
//

import UIKit

class GameHomePageCell: UICollectionViewCell, NibReusable {

    @IBOutlet private weak var gameNameLabel: UILabel!
    @IBOutlet private weak var percentLabel: UILabel!
    @IBOutlet private weak var ratingView: CosmosView!
    @IBOutlet private weak var gameImageView: UIImageView!
    
    var info: GameInfo? {
        
        didSet {
            
            gameNameLabel.text = info?.Title
            percentLabel.text = info?.gsScore
            gameImageView.qy_setImage(info?.DefaultPicUrl, "")
            ratingView.rating = info?.score ?? 0
        }
    }
}
