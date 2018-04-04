//
//  BaseButton.swift
//  GamerSky
//
//  Created by engic on 2018/4/4.
//  Copyright © 2018年 engic. All rights reserved.
//

import UIKit

class BaseButton: UIButton {

    var customFont: UIFont = UIFont.systemFont(ofSize: 14) {
        didSet {
            fitFontSize()
        }
    }
    
    // MARK: - Inital
    public override init(frame: CGRect) {
        super.init(frame: frame)
//        fitFontSize()
    }
    
    open override var buttonType: UIButtonType {
        
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
extension BaseButton {
    
    private func fitFontSize() {
        
        // 如果不想自适应字体大小，把 tag 值设置为666即可
        guard tag != 666 else {return}
        
        titleLabel?.font = UIFont(name: customFont.fontName, size: customFont.pointSize * ScreenWidth / 414)
    }
}
