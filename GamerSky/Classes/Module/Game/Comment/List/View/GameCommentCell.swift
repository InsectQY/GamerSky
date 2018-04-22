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
            gameImageView.qy_setImage(comment.DefaultPicUrl, "")
            contentLabel.text = "APP进行展示的时候，UILabel并不会主动去解析这些含有HTML元素的东西，显示的内容显然不是我们想要的结果。这个时候我就联想到了使用强大的属性字符串去解析，果然就找到了相应的方法"
            userNameLabel.text = comment.nickname
        }
    }
    
    // MARK: - 重写frame
    override var frame: CGRect {
        
        didSet {
            
            var newFrame = frame
            
            newFrame.origin.y += 10
            newFrame.size.height -= 10
            super.frame = newFrame
        }
    }
}
