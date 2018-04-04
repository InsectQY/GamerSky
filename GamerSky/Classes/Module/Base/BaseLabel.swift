//
//  BaseLabel.swift
//  GamerSky
//
//  Created by engic on 2018/4/4.
//  Copyright © 2018年 engic. All rights reserved.
//

import UIKit

class BaseLabel: UILabel {

    // MARK: - Inital
    public override init(frame: CGRect) {
        super.init(frame: frame)
        fitFontSize()
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        fitFontSize()
    }
    
    /// required
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: - 自适应字体(适应比例一开始我是在5.5寸屏幕上测试的，所以拿5.5的比例去缩放)
extension BaseLabel {
   
    private func fitFontSize() {
        
        // 如果不想自适应字体大小，把 tag 值设置为666即可
        guard tag != 666 else {return}
        font = UIFont(name: font.fontName, size: font.pointSize * ScreenWidth / 414)
    }
}
