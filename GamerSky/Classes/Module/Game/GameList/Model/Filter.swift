//
//  Filter.swift
//  BookShopkeeper
//
//  Created by QY on 2018/4/24.
//  Copyright © 2018年 dingding. All rights reserved.
//

import UIKit

struct Filter: Codable {
    
    let name: String
    let id: Int
    
    var size: CGSize {
        
        get {
            
            var size = name.size(Configs.Dimensions.screenWidth, .pingFangSCRegular(14))
            size.width += 30
            return size
        }
    }
}
