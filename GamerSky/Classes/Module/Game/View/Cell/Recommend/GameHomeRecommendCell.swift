//
//  GameHomeRecommendCell.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/9.
//Copyright © 2018年 engic. All rights reserved.
//

import UIKit

class GameHomeRecommendCell: UICollectionViewCell, NibReusable {

    @IBOutlet private weak var backContentView: UIView!
    @IBOutlet private weak var ratingView: CosmosView!
    @IBOutlet private weak var percentLabel: UILabel!
    @IBOutlet private weak var descLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var backgroundImageView: UIImageView!
    
    var detail: GameInfo? {
        
        didSet {
            
            percentLabel.text = detail?.gsScore
            backgroundImageView.qy_setImage(detail?.largeImage, "")
            nameLabel.text = detail?.Title
            descLabel.text = detail?.description
            ratingView.rating = detail?.score ?? 0
        }
    }
        
    // MARK: - inital
    override func awakeFromNib() {
        
        super.awakeFromNib()
        backContentView.layer.borderColor = UIColor.white.withAlphaComponent(0.6).cgColor
    }
    
    override func prepareForReuse() {
        
        ratingView.prepareForReuse()
    }
}
