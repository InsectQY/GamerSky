//
//  Filter.swift
//  BookShopkeeper
//
//  Created by engic on 2018/4/24.
//  Copyright © 2018年 dingding. All rights reserved.
//

import UIKit

struct Filter: Codable {
    
    var name: String
    var id: Int
    
    var size: CGSize {
        
        get {
            
            var size = name.size(ScreenWidth, PFR14Font)
            size.width += 30
            return size
        }
    }
}
