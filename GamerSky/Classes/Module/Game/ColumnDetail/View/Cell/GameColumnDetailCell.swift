//
//  GameColumnDetailCell.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/14.
//Copyright © 2018年 engic. All rights reserved.
//

import UIKit

class GameColumnDetailCell: UITableViewCell, NibReusable {

    // MARK: - IBOutlet
    @IBOutlet private weak var gameNameLabel: BaseLabel!
    @IBOutlet private weak var gamePercentLabel: BaseLabel!
    @IBOutlet private weak var ratingView: CosmosView!
    @IBOutlet private weak var gameTagLabel: BaseLabel!
    @IBOutlet private weak var gameImageView: UIImageView!
    @IBOutlet private weak var ratingBtn: UIButton!
    @IBOutlet private weak var gameDescLabel: UILabel!
    
    // MARK: - inital
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
