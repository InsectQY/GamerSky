//
//  BaseCollectionView.swift
//  BookShopkeeper
//
//  Created by QY on 2018/2/1.
//  Copyright © 2018年 dingding. All rights reserved.
//

import UIKit
import SwiftTheme

class CollectionView: UICollectionView {
    
    /// 默认背景颜色
    private var defaultBackgroundColor = "colors.backgroundColor"

    // MARK: - Inital
    public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
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

extension CollectionView {
    
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

extension CollectionView {
    
    // MARK: - 主题设置
    private func initTheme() {
        
        backgroundColor = .white
        theme_backgroundColor = ThemeColorPicker(keyPath: defaultBackgroundColor)
    }
}
