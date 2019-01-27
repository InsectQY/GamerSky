//
//  BaseTableViewCell.swift
//  BookShopkeeper
//
//  Created by QY on 2018/2/1.
//  Copyright © 2018年 dingding. All rights reserved.
//

import UIKit
import SwiftTheme

class BaseTableViewCell: UITableViewCell {

    /// 默认背景颜色
    private var defaultBackgroundColor = "colors.backgroundColor"
    /// 默认文字颜色
    private var defaultTextColor = "colors.textColor"
    
    // MARK: - Inital
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
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
    
    /// 主题背景颜色(传路径)
    @IBInspectable var qy_themeBackgroundColor: String? {
        
        set {
            
            guard let newValue = newValue else {return}
            defaultBackgroundColor = newValue
            initTheme()
        }
        
        get {
            return defaultBackgroundColor
        }
    }
    
    /// 主题文字颜色(传路径)
    @IBInspectable var qy_themeTextColor: String? {
        
        set {
            
            guard let newValue = newValue else {return}
            defaultTextColor = newValue
            initTheme()
        }
        
        get {
            return defaultTextColor
        }
    }
}

extension BaseTableViewCell {
    
    // MARK: - 主题设置
    private func initTheme() {
        
        contentView.theme_backgroundColor = ThemeColorPicker(keyPath: defaultBackgroundColor)
        contentView.theme_tintColor = ThemeColorPicker(keyPath: defaultBackgroundColor)
        textLabel?.theme_textColor = ThemeColorPicker(keyPath: defaultTextColor)
    }
}
