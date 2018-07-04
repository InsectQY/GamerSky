//
//  ConvertToStringable.swift
//  GamerSky
//
//  Created by QY on 2018/5/24.
//  Copyright © 2018年 QY. All rights reserved.
//

import Foundation

protocol ConvertToStringable {
    
    associatedtype Result: Codable
    var valueString: String { get }
}

extension ConvertToStringable {
    
    func toString(result: Result) -> String {
        
        let data = try? JSONEncoder().encode(result)
        guard let da = data else { return "" }
        guard let st = String.init(data: da, encoding: .utf8) else { return "" }
        return st
    }
}
