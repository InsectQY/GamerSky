//
//  ColumnCell.swift
//  GamerSky
//
//  Created by Insect on 2018/4/5.
//  Copyright © 2018年 engic. All rights reserved.
//

import UIKit

class ColumnListCell: BaseCollectionViewCell, NibReusable {

    // MARK: - IBOutlet
    @IBOutlet private weak var columnLabel: UILabel!
    @IBOutlet private weak var columnImageView: UIImageView!
    
    // MARK: - public
    public var column: ColumnList? {
        
        didSet {
            
            columnLabel.text = column?.title
            columnImageView.qy_setImage(column?.icon, "")
        }
    }
}
