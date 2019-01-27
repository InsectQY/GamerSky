//
//  BaseButton.swift
//  GamerSky
//
//  Created by QY on 2018/4/4.
//  Copyright © 2018年 QY. All rights reserved.
//

import UIKit

class Button: UIButton {

    public var qy_fitFont: UIFont = UIFont.systemFont(ofSize: 14) {
        didSet {
            fitFontSize()
        }
    }
    
    // MARK: - Inital
    public override init(frame: CGRect) {
        super.init(frame: frame)
//        fitFontSize()
    }
    
    open override var buttonType: UIButton.ButtonType {
        
//        fitFontSize()
        return super.buttonType
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
//        fitFontSize()
    }
    
    /// required
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: - 自适应字体(适应比例一开始我是在5.5寸屏幕上测试的，所以拿5.5的比例去缩放)
extension Button {
    
    private func fitFontSize() {
        
        // 如果不想自适应字体大小，把 tag 值设置为666即可
        guard tag != 666 else {return}
        
        titleLabel?.font = UIFont(name: qy_fitFont.fontName, size: qy_fitFont.pointSize * ScreenWidth / 414)
    }
}
