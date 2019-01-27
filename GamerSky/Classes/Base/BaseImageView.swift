//
//  BaseImageView.swift
//  GamerSky
//
//  Created by QY on 2018/4/14.
//  Copyright © 2018年 QY. All rights reserved.
//

import UIKit
import SwiftTheme

class BaseImageView: UIImageView {

    private var defaulBackgroundImage: String = ""

}

extension BaseImageView {
    
    /// 主题图片(传路径)
    @IBInspectable var qy_themeBackgroundImage: String? {
        
        set {
            
            guard let newValue = newValue else {return}
            defaulBackgroundImage = newValue
            initTheme()
        }
        
        get {
            return defaulBackgroundImage
        }
    }
}

extension BaseImageView {

    // MARK: - 主题设置
    private func initTheme() {
        
        theme_image = ThemeImagePicker.init(keyPath: defaulBackgroundImage)
    }
}
