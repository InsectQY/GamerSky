//
//  ChannelListCell.swift
//  GamerSky
//
//  Created by Insect on 2018/4/2.
//  Copyright © 2018年 engic. All rights reserved.
//

import UIKit

class ChannelListCell: BaseTableViewCell, NibReusable {

    @IBOutlet private weak var thumbImageView: UIImageView!
    @IBOutlet private weak var commentCountBtn: BaseButton!
    @IBOutlet private weak var updateTimeLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    
    static let cellHeight: CGFloat = ScreenWidth * 0.22
    
    var channel: ChannelList? {
        
        didSet {
            
            guard let channel = channel else {return}
            
            titleLabel.text = channel.title
            commentCountBtn.setTitle("\(channel.commentsCount)", for: .normal)
            if let urls = channel.thumbnailURLs {
                thumbImageView.qy_setImage(urls.first, "")
            }
        }
    }
    
    // MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        commentCountBtn.customFont = PFR12Font
    }
}
