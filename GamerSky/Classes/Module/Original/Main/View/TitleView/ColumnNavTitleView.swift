//
//  ColumnNavTitleView.swift
//  GamerSky
//
//  Created by Insect on 2018/4/8.
//  Copyright © 2018年 engic. All rights reserved.
//

import UIKit

class ColumnNavTitleView: UIView, NibLoadable {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var titleImageView: UIImageView!
    
    var column: ColumnList? {
        
        didSet {
            
            titleLabel.text = column?.title
            titleImageView.qy_setImage(column?.icon, "")
        }
    }
    
    // MARK: - 适配 iOS 11
    override var intrinsicContentSize: CGSize {
        return UILayoutFittingExpandedSize
    }
}
