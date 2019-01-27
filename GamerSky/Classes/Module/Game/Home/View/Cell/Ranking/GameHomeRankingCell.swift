//
//  GameHomeRankingCell.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/10.
//Copyright © 2018年 QY. All rights reserved.
//

import UIKit

class GameHomeRankingCell: CollectionViewCell, NibReusable {

    // MARK: - IBOutlet
    @IBOutlet private weak var ratingView: CosmosView!
    @IBOutlet private weak var rankingBtn: UIButton!
    @IBOutlet private weak var gameScoreLabel: Label!
    @IBOutlet private weak var gameImageView: UIImageView!
    @IBOutlet private weak var gameNameLabel: Label!
    
    private var rankingImage = [#imageLiteral(resourceName: "common_Icon_Index1_16x18"), #imageLiteral(resourceName: "common_Icon_Index2_16x18"), #imageLiteral(resourceName: "common_Icon_Index3_16x18")]
    
    // MARK: - public
    public var info: GameInfo? {
        
        didSet {
            
            gameNameLabel.text = info?.Title
            gameImageView.qy_setImage(info?.DefaultPicUrl, placeholder: "")
            gameScoreLabel.text = info?.gsScore
            ratingView.rating = info?.score ?? 0
            rankingBtn.setTitle("\(tag + 1)", for: .normal)
            if tag <= rankingImage.count - 1 {
                
                rankingBtn.setTitle("", for: .normal)
                rankingBtn.setImage(rankingImage[tag], for: .normal)
            }else {
                
                rankingBtn.setTitle("\(tag + 1)", for: .normal)
                rankingBtn.setImage(nil, for: .normal)
            }
        }
    }
    
    // MARK: - prepareForReuse
    override func prepareForReuse() {
        ratingView.prepareForReuse()
    }
}
