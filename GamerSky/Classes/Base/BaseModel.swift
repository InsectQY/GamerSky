//
//  BaseModel.swift
//  GamerSky
//
//  Created by QY on 2018/4/2.
//  Copyright © 2018年 QY. All rights reserved.
//

import Foundation

struct BaseModel<T: Codable>: Codable {
    
    let errorCode: Int
    let errorMessage: String
    let result: T
    
    var success: Bool {
        return errorCode == 0
    }
}
