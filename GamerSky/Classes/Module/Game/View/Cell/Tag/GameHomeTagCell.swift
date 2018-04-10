//
//  GameHomeTagCell.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/10.
//Copyright © 2018年 engic. All rights reserved.
//

import UIKit

class GameHomeTagCell: UICollectionViewCell, NibReusable {

    @IBOutlet private weak var gameTagLabel: UILabel!
    
    static let cellHeight: CGFloat = 30
    
    var gameTag: GameTag? {
        
        didSet {
            gameTagLabel.text = gameTag?.name
        }
    }
    
    // MARK: - inital
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpBorder()
    }
    
    // MARK: - 设置边框
    private func setUpBorder() {
        
        layer.cornerRadius = width * 0.1
        layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        layer.borderWidth = 1
    }
}

