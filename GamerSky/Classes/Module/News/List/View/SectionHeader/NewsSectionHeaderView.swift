//
//  NewsSectionHeaderView.swift
//  GamerSky
//
//  Created by engic on 2018/4/4.
//  Copyright © 2018年 engic. All rights reserved.
//

import UIKit
import SwiftTheme

class NewsSectionHeaderView: UITableViewHeaderFooterView, NibReusable {

    static let headerHeight: CGFloat = 20
    
    @IBOutlet private weak var headerImageView: UIImageView!
    @IBOutlet private weak var headerLabel: UILabel!
    
    // MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpTheme()
    }
}

extension NewsSectionHeaderView {
    
    // MARK: - 设置主题
    private func setUpTheme() {
        
        headerImageView.theme_image = "images.common_Icon_Recommend_10x10"
    }
}
