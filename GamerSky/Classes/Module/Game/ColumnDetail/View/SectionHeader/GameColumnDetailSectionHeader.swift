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
    @IBOutlet private weak var titleBtn: UIButton! {
        didSet {
            
            let image = #imageLiteral(resourceName: "common_Icon_Ribbon_94x22_Highlight")
            image.resizableImage(withCapInsets: UIEdgeInsetsMake(0, image.size.width * 0.2, 0, image.size.width * 0.2), resizingMode: .stretch)
            titleBtn.setBackgroundImage(image, for: .normal)
        }
    }
    
    public var title: String? {
        
        didSet {
            
            titleBtn.setTitle(title, for: .normal)
        }
    }
    
    // MARK: - inital
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = .white
    }
}
