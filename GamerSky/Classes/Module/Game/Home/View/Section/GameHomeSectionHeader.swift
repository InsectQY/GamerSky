//
//  GameHomeSectionHeader.swift
//  GamerSky
//
//  Created by Insect on 2018/4/10.
//  Copyright © 2018年 QY. All rights reserved.
//

import UIKit

class GameHomeSectionHeader: UITableViewHeaderFooterView, NibReusable {

    static let sectionHeight: CGFloat = 44
    
    // MARK: - IBOutlet
    @IBOutlet private weak var leftTitleLabel: BaseLabel!
    @IBOutlet private weak var rightTitleBtn: UIButton!
    
    public var sectionData: GameHomeSectionModel? {
        
        didSet {
            
            leftTitleLabel.text = sectionData?.leftTitle
            rightTitleBtn.setTitle(sectionData?.rightTitle, for: .normal)
        }
    }
}
