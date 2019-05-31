//
//  GameHomePageCell.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/10.
//Copyright © 2018年 QY. All rights reserved.
//

import UIKit

class GameHomePageCell: CollectionViewCell, NibReusable {

    // MARK: - IBOutlet
    @IBOutlet private weak var gameImageTopConstraint: NSLayoutConstraint!
    @IBOutlet public  weak var sellMonthLabel: Label!
    @IBOutlet private weak var gameNameLabel: Label!
    @IBOutlet private weak var gameScoreLabel: Label!
    @IBOutlet private weak var gameImageView: UIImageView!
    @IBOutlet private weak var activityImageView: UIImageView!
    @IBOutlet private weak var ratingView: CosmosView! {
        didSet {
            // 按比例缩放星星大小
            ratingView.starSize = Double(12 * Configs.Dimensions.screenWidth / 414)
        }
    }
    
    // MARK: - public
    public var sectionType: GameHomeSectionType? {
        
        didSet {
            
            // 不是即将发售的游戏(隐藏顶部时间, 调整图片到顶部距离(已在xib里计算好, 调整约束优先级即可)
            gameImageTopConstraint.priority = sectionType == .waitSelling ? UILayoutPriority(rawValue: 999) : UILayoutPriority(rawValue: 1)
            
            // 不是最近大家都在玩, 不需要显示评分
            ratingView.isHidden = sectionType != .hot
            gameScoreLabel.textAlignment = sectionType != .hot ? .left : .right
        }
    }
    
    public var info: GameInfo? {
        
        didSet {
            
            gameNameLabel.text = info?.Title
            gameImageView.qy_setImage(info?.DefaultPicUrl, placeholder: "")
            sellMonthLabel.isHidden = tag != 0
            sellMonthLabel.text = "\(info?.month ?? "")月"
            activityImageView.isHidden = !(info?.Position ?? "").contains("活动")
            
            if sectionType == .hot { // 最近大家都在玩,才需要显示评分
                ratingView.rating = info?.score ?? 0
                gameScoreLabel.text = info?.gsScore
            }else { // 显示想玩的人数
                gameScoreLabel.text = "\(info?.wantplayCount ?? 0)人期待"
            }
        }
    }
    
    // MARK: - prepareForReuse
    override func prepareForReuse() {
        ratingView.prepareForReuse()
    }
}
