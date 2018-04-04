//
//  ChannelListCell.swift
//  GamerSky
//
//  Created by Insect on 2018/4/2.
//  Copyright © 2018年 engic. All rights reserved.
//

import UIKit

class ChannelListCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var thumbImageView: UIImageView!
    @IBOutlet private weak var commentCountBtn: BaseButton!
    @IBOutlet private weak var updateTimeLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    
    var channel: ChannelList? {
        
        didSet {
            
            guard let channel = channel else {return}
            
            titleLabel.text = channel.title
            commentCountBtn.setTitle("\(channel.commentsCount)", for: .normal)
            if let urls = channel.thumbnailURLs {
                thumbImageView.setImage(urls.first, "")
            }
        }
    }
    
    // MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpTheme()
        commentCountBtn.customFont = PFR12Font
    }
}

extension ChannelListCell {
    
    // MARK: - 设置主题
    private func setUpTheme() {
        
        contentView.theme_backgroundColor = "colors.backgroundColor"
    }
}
