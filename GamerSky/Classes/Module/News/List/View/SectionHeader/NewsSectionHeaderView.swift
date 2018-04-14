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

    static let height: CGFloat = 20
    
    @IBOutlet private weak var headerImageView: UIImageView!
    @IBOutlet private weak var headerLabel: UILabel!
}
