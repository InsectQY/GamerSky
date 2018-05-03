//
//  IntExtension.swift
//  GamerSky
//
//  Created by engic on 2018/5/3.
//  Copyright © 2018年 engic. All rights reserved.
//

import Foundation

extension Int {
    
    public func compare() -> String {
        
        let timeDate = Date(timeIntervalSince1970: TimeInterval(self / 1000))
        var timeInterval = timeDate.timeIntervalSinceNow
        
        timeInterval = -timeInterval
        let section = Int(timeInterval)
        let minute = section / 60
        let hour = minute / 60
        let day = hour / 24
        
        var result = ""
        
        if timeInterval < 60 {
            result = "刚刚"
        }else if minute < 60 {
            result = "\(minute)分钟前"
        }else if hour < 24 {
            result = "\(hour)小时前"
        }else if day <= 7 {
            result = "\(day)天前"
        }else {
            result = timeDate.string(withFormat: "MM月dd日")
        }
        
        return result
    }
}
