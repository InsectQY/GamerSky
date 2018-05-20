//
//  ColumnListCell.swift
//  GamerSky
//
//  Created by Insect on 2018/4/3.
//  Copyright © 2018年 QY. All rights reserved.
//

import UIKit
import SwiftTheme

class ColumnElementCell: UITableViewCell, NibReusable {

    static let cellHeight: CGFloat = 250
    
    // MARK: - IBOutlet
    @IBOutlet private weak var bottomContentView: BaseView!
    @IBOutlet private weak var columnNameLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var updateTimeLabel: UILabel!
    @IBOutlet private weak var authorNameLabel: UILabel!
    @IBOutlet private weak var thumbImageView: UIImageView!
    @IBOutlet private weak var authorImageView: UIImageView!
    @IBOutlet private weak var commentsBtn: BaseButton! {
        didSet{
            commentsBtn.qy_fitFont = PFR12Font
        }
    }
    
    // MARK: - public
    public var row = 0
    
    public var columnElement: ColumnElement? {
        
        didSet {
            
            columnNameLabel.text = columnElement?.zhuanlanTitle
            titleLabel.text = columnElement?.title
            authorNameLabel.text = columnElement?.authorName
            thumbImageView.qy_setImage(columnElement?.thumbnailURL, "")
            authorImageView.qy_setImage(columnElement?.authorPhoto, "")
            commentsBtn.setTitle("\(columnElement?.commentsCount ?? 0)", for: .normal)
            updateTimeLabel.text = columnElement?.updateTimeString
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
}
