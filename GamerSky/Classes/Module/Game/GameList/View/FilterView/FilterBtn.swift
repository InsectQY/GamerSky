//
//  FilterBtn.swift
//  GamerSky
//
//  Created by QY on 2018/5/2.
//  Copyright © 2018年 QY. All rights reserved.
//

import UIKit

class FilterBtn: UIButton {

    private let selBorderColor: UIColor = .RGBA(168, 203, 184)
    private let selTitleColor: UIColor = .RGBA(100, 173, 125)
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        cornerRadius = width * 0.2
    }
    
    @IBInspectable var isSel: Bool = false {
        
        didSet {
            
            if isSel { // 选中状态
                
                borderColor = selBorderColor
                setTitleColor(selTitleColor, for: .normal)
            }else { // 普通状态
                
                borderColor = .clear
                setTitleColor(.black, for: .normal)
            }
        }
    }
}
