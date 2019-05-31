//
//  BaseLabel.swift
//  GamerSky
//
//  Created by QY on 2018/4/4.
//  Copyright © 2018年 QY. All rights reserved.
//

import UIKit
import SwiftTheme

class Label: UILabel {

    /// 默认颜色
    private var defaultTextColor = "colors.textColor"
    
    // MARK: - Inital
    public override init(frame: CGRect) {
        super.init(frame: frame)
        fitFontSize()
        initTheme()
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        fitFontSize()
        initTheme()
    }
    
    /// required
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension Label {
    
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

extension Label {
   
    // MARK: - 自适应字体(适应比例一开始我是在5.5寸屏幕上测试的，所以拿5.5的比例去缩放)
    private func fitFontSize() {
        
        // 如果不想自适应字体大小，把 tag 值设置为666即可
        guard tag != 666 else {return}
        font = UIFont(name: font.fontName, size: font.pointSize * Configs.Dimensions.screenWidth / 414)
    }
    
    // MARK: - 主题设置
    private func initTheme() {
        
        // 如果不想设置主题颜色，把 tag 值设置为777即可
        guard tag != 777 else {return}
        theme_textColor = ThemeColorPicker(keyPath: defaultTextColor)
    }
}
