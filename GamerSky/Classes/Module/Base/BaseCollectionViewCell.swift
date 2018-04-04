//
//  BaseCollectionViewCell.swift
//  BookShopkeeper
//
//  Created by engic on 2018/2/1.
//  Copyright © 2018年 dingding. All rights reserved.
//

import UIKit
import SwiftTheme

class BaseCollectionViewCell: UICollectionViewCell {
    
    /// 主题背景颜色(传路径)
    public var qy_themeBackgroundColor = "colors.backgroundColor" {
        
        didSet {
            initTheme()
        }
    }
    
    // MARK: - Inital
    override init(frame: CGRect) {
        super.init(frame: frame)
        initTheme()
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        initTheme()
    }
    
    /// required
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension BaseCollectionViewCell {
   
    // MARK: - 主题设置
    private func initTheme() {
        theme_backgroundColor = ThemeColorPicker(keyPath: qy_themeBackgroundColor)
    }
}
