//
//  ColumnCell.swift
//  GamerSky
//
//  Created by Insect on 2018/4/5.
//  Copyright © 2018年 engic. All rights reserved.
//

import UIKit

class ColumnListCell: UICollectionViewCell, NibReusable {

    @IBOutlet private weak var columnLabel: UILabel!
    @IBOutlet private weak var columnImageView: UIImageView!
    
    var column: ColumnList? {
        
        didSet {
            
            columnLabel.text = column?.title
            columnImageView.setImage(column?.icon, "")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
