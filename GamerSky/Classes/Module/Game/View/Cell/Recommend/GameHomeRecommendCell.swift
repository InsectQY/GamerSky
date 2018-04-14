//
//  GameHomeRecommendCell.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/9.
//Copyright © 2018年 engic. All rights reserved.
//

import UIKit

class GameHomeRecommendCell: UICollectionViewCell, NibReusable {

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
            backgroundImageView.qy_setImage(detail?.largeImage, "")
            nameLabel.text = detail?.Title
            descLabel.text = detail?.description
            ratingView.rating = detail?.score ?? 0
            activityImageView.isHidden = !(detail?.Position ?? "").contains("活动")
        }
    }
        
    // MARK: - awakeFromNib
    override func awakeFromNib() {
        
        super.awakeFromNib()
        backContentView.layer.borderColor = UIColor.white.withAlphaComponent(0.6).cgColor
    }
    
    // MARK: - prepareForReuse
    override func prepareForReuse() {
        ratingView.prepareForReuse()
    }
}
