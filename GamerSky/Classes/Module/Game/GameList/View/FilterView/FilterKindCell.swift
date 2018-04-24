//
//  FilterCell.swift
//  BookShopkeeper
//
//  Created by engic on 2018/1/17.
//Copyright © 2018年 dingding. All rights reserved.
//

import UIKit

class FilterKindCell: UICollectionViewCell, NibReusable {
    
    @IBOutlet private weak var filterBtn: UIButton!
    
    var filterClick: ((UIButton) -> ())?
    
    var content: String? {
        didSet {
            filterBtn.setTitle(content, for: .normal)
        }
    }
    
    @IBAction func filterBtnDidClick() {
        filterClick?(filterBtn)
    }
}
