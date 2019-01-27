//
//  BaseTableView.swift
//  BookShopkeeper
//
//  Created by QY on 2018/2/1.
//  Copyright © 2018年 dingding. All rights reserved.
//

import UIKit
import SwiftTheme

class TableView: UITableView {
    
    /// 默认背景颜色
    private var defaultBackgroundColor = "colors.backgroundColor"
    
    // MARK: - Inital
    public override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
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

extension TableView {
    
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
}

extension TableView {
    
    // MARK: - 主题设置
    private func initTheme() {
        
        theme_backgroundColor = ThemeColorPicker(keyPath: defaultBackgroundColor)
    }
}
