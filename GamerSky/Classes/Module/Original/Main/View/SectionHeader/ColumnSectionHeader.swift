//
//  ColumnSectionHeader.swift
//  GamerSky
//
//  Created by engic on 2018/4/8.
//  Copyright © 2018年 engic. All rights reserved.
//

import UIKit

class ColumnSectionHeader: UITableViewHeaderFooterView, NibReusable {

    static let sectionHeight: CGFloat = 35
    
    @IBOutlet private weak var headerImageView: UIImageView!
    @IBOutlet private weak var headerTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
