//
//  ColumnListCell.swift
//  GamerSky
//
//  Created by Insect on 2018/4/3.
//  Copyright © 2018年 engic. All rights reserved.
//

import UIKit
import SwiftTheme

class ColumnElementCell: BaseTableViewCell, NibReusable {

    @IBOutlet private weak var bottomContentView: BaseView!
    @IBOutlet private weak var columnNameLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var updateTimeLabel: UILabel!
    @IBOutlet private weak var authorNameLabel: UILabel!
    @IBOutlet private weak var commentsBtn: BaseButton!
    @IBOutlet private weak var thumbImageView: UIImageView!
    @IBOutlet private weak var authorImageView: UIImageView!
    
    var row = 0
    
    var columnElement: ColumnElement? {
        
        didSet {
            
            columnNameLabel.text = columnElement?.zhuanlanTitle
            titleLabel.text = columnElement?.title
            authorNameLabel.text = columnElement?.authorName
            thumbImageView.setImage(columnElement?.thumbnailURL, "")
            authorImageView.setImage(columnElement?.authorPhoto, "")
            commentsBtn.setTitle("\(columnElement?.commentsCount ?? 0)", for: .normal)
        }
    }
    
    // MARK: - 重写frame
    override var frame: CGRect {
        
        didSet {
            
            var newFrame = frame
            if row != 0 {
                
                newFrame.origin.y += 15
                newFrame.size.height -= 15
            }
            newFrame.origin.x += 10
            newFrame.size.width -= 20
            super.frame = newFrame
        }
    }
    
    // MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpTheme()
        commentsBtn.customFont = PFR12Font
    }
}

extension ColumnElementCell {
    
    // MARK: - 设置主题
    private func setUpTheme() {
        
        bottomContentView.qy_themeBackgroundColor = "colors.dimBlack"
    }
}
