//
//  BaseModel.swift
//  GamerSky
//
//  Created by engic on 2018/4/2.
//  Copyright © 2018年 engic. All rights reserved.
//

import Foundation

struct BaseModel<T: Codable>: Codable {
    
    var errorCode: Int
    var errorMessage: String?
    var result: T
}
