//
//  BaseTableViewCell.swift
//  BookShopkeeper
//
//  Created by engic on 2018/2/1.
//  Copyright © 2018年 dingding. All rights reserved.
//

import UIKit
import SwiftTheme

class BaseTableViewCell: UITableViewCell {

    /// 主题背景颜色(传路径)
    public var themeBackgroundColor = "colors.backgroundColor" {
        
        didSet {
            initTheme()
        }
    }
    
    /// 主题文字颜色(传路径)
    public var themeTextLabelColor = "colors.textColor" {
        
        didSet {
            initTheme()
        }
    }
    
    // MARK: - Inital
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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

extension BaseTableViewCell {
    
    // MARK: - 主题设置
    private func initTheme() {
        
        theme_backgroundColor = ThemeColorPicker(keyPath: themeBackgroundColor)
        textLabel?.theme_textColor = ThemeColorPicker(keyPath: themeTextLabelColor)
    }
}
