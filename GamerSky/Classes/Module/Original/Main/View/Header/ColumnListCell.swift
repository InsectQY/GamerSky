//
//  ColumnCell.swift
//  GamerSky
//
//  Created by Insect on 2018/4/5.
//  Copyright © 2018年 engic. All rights reserved.
//

import UIKit

class ColumnListCell: BaseCollectionViewCell, NibReusable {

    @IBOutlet private weak var columnLabel: UILabel!
    @IBOutlet private weak var columnImageView: UIImageView!
    
    var column: ColumnList? {
        
        didSet {
            
            columnLabel.text = column?.title
            columnImageView.setImage(column?.icon, "")
        }
    }
    
    // MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpTheme()
    }
}

extension ColumnListCell {
    
    // MARK: - 设置主题
    private func setUpTheme() {
        
        qy_themeBackgroundColor = "colors.dimBlack"
    }
}
