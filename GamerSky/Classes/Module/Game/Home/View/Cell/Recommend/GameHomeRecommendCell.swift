//
//  GameHomeRecommendCell.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/9.
//Copyright © 2018年 QY. All rights reserved.
//

import UIKit

class GameHomeRecommendCell: CollectionViewCell, NibReusable {

    // MARK: - IBOutlet
    @IBOutlet private weak var backContentView: UIView!
    @IBOutlet private weak var ratingView: CosmosView!
    @IBOutlet private weak var percentLabel: UILabel!
    @IBOutlet private weak var descLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var backgroundImageView: UIImageView!
    @IBOutlet private weak var activityImageView: UIImageView!
    
    // MARK: - public
    public var detail: GameInfo? {
        
        didSet {
            
            percentLabel.text = detail?.gsScore
            backgroundImageView.qy_setImage(detail?.largeImage, placeholder: "")
            nameLabel.text = detail?.Title
            descLabel.text = detail?.description
            ratingView.rating = detail?.score ?? 0
            activityImageView.isHidden = !(detail?.Position ?? "").contains("活动")
        }
    }
    
    // MARK: - prepareForReuse
    override func prepareForReuse() {
        ratingView.prepareForReuse()
    }
}
