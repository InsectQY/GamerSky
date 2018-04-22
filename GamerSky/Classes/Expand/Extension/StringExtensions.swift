//
//  StringExtensions.swift
//  GamerSky
//
//  Created by Insect on 2018/4/17.
//  Copyright © 2018年 engic. All rights reserved.
//

import Foundation

extension String {
    
    public func date(withFormat format: String) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
    
    public var htmlAttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: Data(utf8),
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
    
    public var htmlString: String {
        return htmlAttributedString?.string ?? ""
    }
}
