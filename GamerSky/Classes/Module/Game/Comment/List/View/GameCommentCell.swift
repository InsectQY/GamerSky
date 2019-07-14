//
//  GameCommentCell.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/22.
//Copyright © 2018年 QY. All rights reserved.
//

import UIKit

class GameCommentCell: UITableViewCell, NibReusable {

    // MARK: - IBOutlet
    @IBOutlet private weak var userProfileImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: Label!
    @IBOutlet private weak var playTypeLabel: Label!
    @IBOutlet private weak var commentTimeLabel: Label!
    @IBOutlet private weak var commentBtn: UIButton!
    @IBOutlet private weak var likeBtn: UIButton!
    @IBOutlet private weak var contentLabel: Label!
    @IBOutlet private weak var gameImageView: UIImageView!
    @IBOutlet private weak var gameNameLabel: Label!
    @IBOutlet private weak var gameTagsLabel: Label!
    @IBOutlet private weak var gameRatingView: CosmosView!
    @IBOutlet private weak var gameScoreLabel: Label!
    @IBOutlet private weak var commentRatingView: CosmosView!
    
    public var comment: GameComment? {
        
        didSet {
            
            guard let comment = comment else {return}
            
            userProfileImageView.qy_setImage(comment.img_URL)
            gameImageView.qy_setImage(comment.DefaultPicUrl)
            contentLabel.attributedText = comment.content.htmlString.getAttributeStringWith(lineSpace: 10)
            gameNameLabel.text = comment.Title
            userNameLabel.text = comment.nickname
            gameTagsLabel.text = comment.gameTagString
            likeBtn.setTitle(" \(comment.like)", for: .normal)
            commentBtn.setTitle(" \(comment.reviewCount)", for: .normal)
            commentRatingView.rating = comment.commentRating
            if comment.likeType == .played { // 玩过
                
                if let platform = comment.platform {
                    playTypeLabel.text = platform.count > 0 ? "在\(platform)平台上玩过" : "玩过"
                }
            }else { // 没玩过
                playTypeLabel.text = "想玩"
            }
        }
    }
    
    // MARK: - prepareForReuse
    override func prepareForReuse() {
        gameRatingView.prepareForReuse()
    }
}
