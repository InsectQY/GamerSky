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
    @IBOutlet private weak var userProfileImageView: UIImageView! {
        didSet {
            userProfileImageView.cornerRadius = userProfileImageView.width * 0.5
        }
    }
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
            contentLabel.text = comment.content
            userNameLabel.text = comment.nickname
        }
    }
    
    
    // MARK: - inital
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
