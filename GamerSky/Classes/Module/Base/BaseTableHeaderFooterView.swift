//
//  BaseTableHeaderFooterView.swift
//  GamerSky
//
//  Created by engic on 2018/4/4.
//  Copyright © 2018年 engic. All rights reserved.
//

import UIKit
import SwiftTheme

class BaseTableHeaderFooterView: UITableViewHeaderFooterView {

    /// 主题背景颜色(传路径)
    public var qy_themeBackgroundColor = "colors.backgroundColor" {
        
        didSet {
            initTheme()
        }
    }
    
    // MARK: - Inital
    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        initTheme()
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        initTheme()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BaseTableHeaderFooterView {
    
    // MARK: - 主题设置
    private func initTheme() {
        theme_backgroundColor = ThemeColorPicker(keyPath: qy_themeBackgroundColor)
    }
}
