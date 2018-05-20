//
//  GameColumnDetailCell.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/14.
//Copyright © 2018年 QY. All rights reserved.
//

import UIKit

class GameColumnDetailCell: UITableViewCell, NibReusable {

    // MARK: - IBOutlet
    @IBOutlet private weak var gameNameLabel: BaseLabel!
    @IBOutlet private weak var gameScoreLabel: BaseLabel!
    @IBOutlet private weak var ratingView: CosmosView!
    @IBOutlet private weak var gameTagLabel: BaseLabel!
    @IBOutlet private weak var gameImageView: UIImageView!
    @IBOutlet private weak var rankingBtn: UIButton!
    @IBOutlet private weak var gameDescLabel: BaseLabel!
    @IBOutlet private weak var activityImageView: UIImageView!
    @IBOutlet private weak var gameImageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var gameScoreLabelLeadingConstraint: NSLayoutConstraint!
    @IBOutlet public weak var descLabelBottomConstraint: NSLayoutConstraint!
    
    
    private var rankingImage = [#imageLiteral(resourceName: "common_Icon_Index1_16x18"), #imageLiteral(resourceName: "common_Icon_Index2_16x18"), #imageLiteral(resourceName: "common_Icon_Index3_16x18")]
    
    public var isHasSubList: Bool = false {
        
        didSet {
            
            /// 多组则隐藏排名
            if isHasSubList {
                
                rankingBtn.isHidden = true
                gameImageViewLeadingConstraint.priority = UILayoutPriority(rawValue: 999)
            }
        }
    }
    
    public var specitial: GameSpecialDetail? {
        
        didSet {
            
            guard let specitial = specitial else {return}
            
            gameImageView.qy_setImage(specitial.DefaultPicUrl, "")
            gameNameLabel.text = specitial.Title
            gameDescLabel.text = specitial.description
            gameTagLabel.text = specitial.gameTagString
            activityImageView.isHidden = !specitial.Position.contains("活动")
            if specitial.gsScore == "0" { // 没有评分
                
                gameScoreLabelLeadingConstraint.priority = UILayoutPriority(rawValue: 999)
                gameScoreLabel.text = "暂无评分"
                ratingView.isHidden = true
            }else {
                
                gameScoreLabelLeadingConstraint.priority = UILayoutPriority(rawValue: 1)
                gameScoreLabel.text = specitial.gsScore
                ratingView.rating = specitial.score
                ratingView.isHidden = false
            }
            
            if tag <= rankingImage.count - 1 {
                
                rankingBtn.setTitle("", for: .normal)
                rankingBtn.setImage(rankingImage[tag], for: .normal)
            }else {
                rankingBtn.setTitle("\(tag + 1)", for: .normal)
                rankingBtn.setImage(nil, for: .normal)
            }
        }
    }
    
    // MARK: - 重写frame
    override var frame: CGRect {
        
        didSet {
            
            if isHasSubList {return}
            var newFrame = frame
            
            newFrame.origin.y += 10
            newFrame.size.height -= 10
            super.frame = newFrame
        }
    }
    
    // MARK: - prepareForReuse
    override func prepareForReuse() {
        ratingView.prepareForReuse()
    }
}
