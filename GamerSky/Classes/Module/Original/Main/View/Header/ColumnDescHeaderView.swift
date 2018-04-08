//
//  ColumnDescHeaderView.swift
//  GamerSky
//
//  Created by Insect on 2018/4/8.
//  Copyright © 2018年 engic. All rights reserved.
//

import UIKit

class ColumnDescHeaderView: UIView, NibLoadable {

    @IBOutlet private weak var descView: UIView!
    @IBOutlet private weak var descLabel: UILabel!
    
    var desc: String? {
        didSet {
            descLabel.text = desc
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
