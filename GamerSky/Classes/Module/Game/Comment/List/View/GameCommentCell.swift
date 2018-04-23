//
//  GameCommentCell.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/22.
//Copyright © 2018年 engic. All rights reserved.
//

import UIKit

class GameCommentCell: UITableViewCell, NibReusable {

    // MARK: - IBOutlet
    @IBOutlet private weak var userProfileImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: BaseLabel!
    @IBOutlet private weak var playTypeLabel: BaseLabel!
    @IBOutlet private weak var commentTimeLabel: BaseLabel!
    @IBOutlet private weak var commentBtn: UIButton!
    @IBOutlet private weak var likeBtn: UIButton!
    @IBOutlet private weak var contentLabel: BaseLabel!
    @IBOutlet private weak var gameImageView: UIImageView!
    @IBOutlet private weak var gameNameLabel: BaseLabel!
    @IBOutlet private weak var gameTagsLabel: BaseLabel!
    @IBOutlet private weak var gameRatingView: CosmosView!
    @IBOutlet private weak var gameScoreLabel: BaseLabel!
    
    public var comment: GameComment? {
        
        didSet {
            
            guard let comment = comment else {return}
            
            userProfileImageView.qy_setImage(comment.img_URL, "")
            gameImageView.qy_setImage(comment.DefaultPicUrl, "")
            contentLabel.attributedText = comment.content.htmlString.getAttributeStringWith(lineSpace: 10)
            userNameLabel.text = comment.nickname
        }
    }
}
