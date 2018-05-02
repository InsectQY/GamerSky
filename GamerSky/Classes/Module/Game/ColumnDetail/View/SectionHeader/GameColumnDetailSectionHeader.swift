//
//  GameColumnDetailSectionHeader.swift
//  GamerSky
//
//  Created by QY on 2018/4/14.
//  Copyright © 2018年 engic. All rights reserved.
//

import UIKit

class GameColumnDetailSectionHeader: UITableViewHeaderFooterView, NibReusable {

    /// 高度
    static let sectionHeight: CGFloat = 44
    // MARK: - IBOutlet
    @IBOutlet private weak var titleBtn: UIButton! 
    @IBOutlet private weak var titleBtnWidthConstraint: NSLayoutConstraint!
    
    public var title: String? {
        
        didSet {
            
            titleBtn.setTitle(title, for: .normal)
            titleBtnWidthConstraint.constant = (title?.size(ScreenWidth, PFR13Font).width ?? 0) + 90
        }
    }
    
    // MARK: - inital
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = .white
    }
}
