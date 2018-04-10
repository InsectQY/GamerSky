//
//  GameHomeRankingCell.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/10.
//Copyright © 2018年 engic. All rights reserved.
//

import UIKit

class GameHomeRankingCell: UICollectionViewCell, NibReusable {

    @IBOutlet private weak var ratingView: CosmosView!
    @IBOutlet private weak var rankingBtn: UIButton!
    @IBOutlet private weak var percentLabel: BaseLabel!
    @IBOutlet private weak var gameImageView: UIImageView!
    @IBOutlet private weak var gameNameLabel: UILabel!
    
    var row = 0 {
        
        didSet {
            rankingBtn.setTitle("\(row)", for: .normal)
        }
    }
    
    var info: GameInfo? {
        
        didSet {
            
            gameNameLabel.text = info?.Title
            gameImageView.qy_setImage(info?.DefaultPicUrl, "")
            percentLabel.text = info?.gsScore
            ratingView.rating = info?.score ?? 0
        }
    }
}
