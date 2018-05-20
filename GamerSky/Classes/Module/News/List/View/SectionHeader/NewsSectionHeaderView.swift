//
//  NewsSectionHeaderView.swift
//  GamerSky
//
//  Created by QY on 2018/4/4.
//  Copyright © 2018年 QY. All rights reserved.
//

import UIKit
import SwiftTheme

class NewsSectionHeaderView: UITableViewHeaderFooterView, NibReusable {

    static let height: CGFloat = 20
    
    // MARK: - IBOutlet
    @IBOutlet private weak var headerImageView: UIImageView!
    @IBOutlet private weak var headerLabel: UILabel!
}
