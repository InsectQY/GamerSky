//
//  BaseLabel.swift
//  GamerSky
//
//  Created by engic on 2018/4/4.
//  Copyright © 2018年 engic. All rights reserved.
//

import UIKit
import SwiftTheme

class BaseLabel: UILabel {

    /// 主题文字颜色(传路径)
    public var themeTextColor = "colors.textColor" {
        
        didSet {
            initTheme()
        }
    }
    
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

extension BaseLabel {
   
    // MARK: - 自适应字体(适应比例一开始我是在5.5寸屏幕上测试的，所以拿5.5的比例去缩放)
    private func fitFontSize() {
        
        // 如果不想自适应字体大小，把 tag 值设置为666即可
        guard tag != 666 else {return}
        font = UIFont(name: font.fontName, size: font.pointSize * ScreenWidth / 414)
    }
    
    // MARK: - 主题设置
    private func initTheme() {
        theme_textColor = ThemeColorPicker(keyPath: themeTextColor)
    }
}
