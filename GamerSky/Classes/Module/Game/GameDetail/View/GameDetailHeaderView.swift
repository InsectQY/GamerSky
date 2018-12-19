//
//  GameDetailHeaderView.swift
//  GamerSky
//
//  Created by insect_qy on 2018/7/13.
//  Copyright © 2018年 QY. All rights reserved.
//

import UIKit

class GameDetailHeaderView: UIView, NibLoadable {
    
    static let height: CGFloat = 350
    
    // MARK: - IBOutlet
    @IBOutlet private weak var bgImageView: UIImageView!
    @IBOutlet private weak var thumbImageView: UIImageView!
    @IBOutlet private weak var ratingView: CosmosView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    public var detail: GameDetail? {
        
        didSet {
            
            guard let detail = detail else {return}
            
            bgImageView.qy_setImage(detail.thumbnailURL, placeholder: "")
            thumbImageView.qy_setImage(detail.thumbnailURL, placeholder: "")
            nameLabel.text = "\(detail.title) \(detail.englishTitle)"
        }
    }
}
