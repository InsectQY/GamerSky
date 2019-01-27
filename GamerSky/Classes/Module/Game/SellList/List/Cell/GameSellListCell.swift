//
//  GameSellListCell.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/17.
//Copyright © 2018年 QY. All rights reserved.
//

import UIKit

class GameSellListCell: UITableViewCell, NibReusable {

    static let cellHeight: CGFloat = ScreenWidth * 0.28 + 30
    
    // MARK: - IBOutlet
    @IBOutlet private weak var gameImageView: UIImageView!
    @IBOutlet private weak var gameNameLabel: Label!
    @IBOutlet private weak var ratingView: CosmosView!
    @IBOutlet private weak var gameScoreLabel: Label!
    @IBOutlet private weak var gamePlatformLabel: Label!
    @IBOutlet private weak var gameTypeLabel: Label!
    @IBOutlet private weak var sellTimeLabel: Label!
    
    public var item: GameSellList? {
        
        didSet {
            
            guard let gameInfo = item else {return}
            gameNameLabel.text = gameInfo.title
            
            gameImageView.qy_setImage(gameInfo.thumbnailURL, placeholder: "")
            gamePlatformLabel.text = "游戏平台: \(gameInfo.platform)"
            gameTypeLabel.text = "游戏类型: \(gameInfo.gameType)"
            sellTimeLabel.text = "发售时间: \(gameInfo.sellTime)"
        }
    }
    
    // MARK: - prepareForReuse
    override func prepareForReuse() {
        ratingView.prepareForReuse()
    }
}
