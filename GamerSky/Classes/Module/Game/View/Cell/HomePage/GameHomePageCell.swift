//
//  GameHomePageCell.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/10.
//Copyright © 2018年 engic. All rights reserved.
//

import UIKit

class GameHomePageCell: UICollectionViewCell, NibReusable {

    // MARK: - IBOutlet
    @IBOutlet private weak var percentLabelLeftConstraint: NSLayoutConstraint!
    @IBOutlet private weak var gameImageTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var gameImageConstraintH: NSLayoutConstraint!
    @IBOutlet private weak var sellMonthLabel: BaseLabel!
    @IBOutlet private weak var gameNameLabel: UILabel!
    @IBOutlet private weak var percentLabel: UILabel!
    @IBOutlet private weak var ratingView: CosmosView!
    @IBOutlet private weak var gameImageView: UIImageView!
    
    // MARK: - public
    public var sectionType: GameHomeSectionType? {
        
        didSet {
    
            guard let sectionType = sectionType else {return}
            
            if sectionType == .waitSelling { // 即将发售的游戏，重新计算图片高度(已在xib里计算好, 调整约束优先级即可)
                gameImageConstraintH.priority = UILayoutPriority(rawValue: 1)
            }else { // 不是即将发售的游戏(隐藏顶部时间, 调整图片到顶部距离(已在xib里计算好, 调整约束优先级即可)
                gameImageTopConstraint.priority = UILayoutPriority(rawValue: 1)
            }
            
            // 不是最近大家都在玩, 不需要显示评分
            ratingView.isHidden = sectionType != .hot
            if sectionType != .hot {
                
                percentLabelLeftConstraint.priority = UILayoutPriority(rawValue: 1)
            }
        }
    }
    
    public var info: GameInfo? {
        
        didSet {
            
            gameNameLabel.text = info?.Title
            gameImageView.qy_setImage(info?.DefaultPicUrl, "")
            sellMonthLabel.isHidden = tag != 0
            sellMonthLabel.text = "\(info?.month ?? "")月"
            
            if sectionType == .hot { // 最近大家都在玩,才需要显示评分
                ratingView.rating = info?.score ?? 0
                percentLabel.text = info?.gsScore
            }else { // 显示想玩的人数
                percentLabel.text = "\(info?.wantplayCount ?? 0)人期待"
            }
        }
    }
}
