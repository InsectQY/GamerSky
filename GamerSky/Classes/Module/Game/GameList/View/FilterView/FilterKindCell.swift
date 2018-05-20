//
//  FilterCell.swift
//  BookShopkeeper
//
//  Created by QY on 2018/1/17.
//Copyright © 2018年 dingding. All rights reserved.
//

import UIKit

class FilterKindCell: UICollectionViewCell, NibReusable {
    
    @IBOutlet private weak var filterBtn: FilterBtn!
    
    /// 点击回调
    var filterClick: ((Filter) -> ())?
    /// 内部按钮是否选中
    var isSel: Bool = false {
        didSet {
            filterBtn.isSel = isSel
        }
    }
    
    var filter: Filter? {
        didSet {
            filterBtn.setTitle(filter?.name, for: .normal)
        }
    }
    
    /// 选中了某个属性
    @IBAction private func filterBtnDidClick() {
        filterClick?(filter!)
    }
}
