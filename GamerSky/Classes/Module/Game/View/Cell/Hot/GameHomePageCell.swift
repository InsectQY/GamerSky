//
//  GameHomePageCell.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/10.
//Copyright © 2018年 engic. All rights reserved.
//

import UIKit

class GameHomePageCell: UICollectionViewCell, NibReusable {

    @IBOutlet private weak var gameImageTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var gameImageConstraintH: NSLayoutConstraint!
    @IBOutlet private weak var sellMonthLabel: BaseLabel!
    @IBOutlet private weak var gameNameLabel: UILabel!
    @IBOutlet private weak var percentLabel: UILabel!
    @IBOutlet private weak var ratingView: CosmosView!
    @IBOutlet private weak var gameImageView: UIImageView!
    
    public var sectionType: GameHomeSectionType? {
        
        didSet {
    
            guard let sectionType = sectionType else {return}
    
            if sectionType == .waitSelling { // 即将发售的游戏，重新计算图片高度(已在xib里计算好, 调整约束优先级即可)
                gameImageConstraintH.priority = UILayoutPriority(rawValue: 1)
            }else { // 不是即将发售的游戏(隐藏顶部时间, 调整图片到顶部距离(已在xib里计算好, 调整约束优先级即可)
                gameImageTopConstraint.priority = UILayoutPriority(rawValue: 1)
            }
        }
    }
    
    var info: GameInfo? {
        
        didSet {
            
            gameNameLabel.text = info?.Title
            percentLabel.text = info?.gsScore
            gameImageView.qy_setImage(info?.DefaultPicUrl, "")
            ratingView.rating = info?.score ?? 0
        }
    }
}
