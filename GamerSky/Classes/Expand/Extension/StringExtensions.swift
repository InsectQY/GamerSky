//
//  StringExtensions.swift
//  GamerSky
//
//  Created by Insect on 2018/4/17.
//  Copyright © 2018年 QY. All rights reserved.
//

import UIKit

extension String {
    
    func toObject<T>(_ : T.Type) -> T? where T: Codable {
        
        guard let data = self.data(using: .utf8) else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }
    
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
    
    // MARK: - 计算大小
    public func size(_ width: CGFloat, _ font: UIFont, _ lineSpeace: CGFloat? = 0) -> CGSize {
        
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        
        // 行距
        let paragraphStye = NSMutableParagraphStyle()
        paragraphStye.lineSpacing = lineSpeace ?? 0
        // 字体属性
        let attributes = [NSAttributedString.Key.font: font,
                          NSAttributedString.Key.paragraphStyle: paragraphStye]
        // 计算宽高
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributes, context: nil)
        return boundingBox.size
    }
    
    public var htmlString: String {
        return htmlAttributedString?.string ?? ""
    }
    
    public func getAttributeStringWith(lineSpace: CGFloat
        ) -> NSAttributedString {
        
        let attributedString = NSMutableAttributedString(string: self)
        let paragraphStye = NSMutableParagraphStyle()
        
        //调整行间距
        paragraphStye.lineSpacing = lineSpace
        let rang = NSMakeRange(0, CFStringGetLength(self as CFString?))
        attributedString .addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStye, range: rang)
        return attributedString
    }

    public func classType<T>(_ type: T.Type) -> T.Type? {

        guard let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
            return nil
        }
        guard let nameSpaceClass = NSClassFromString(nameSpace + "." + self) else {
            return nil
        }
        guard let classType = nameSpaceClass as? T.Type else {
            return nil
        }
        return classType
    }

    public func classObject<T: NSObject>(_ type: T.Type) -> T? {

        guard let classType = classType(T.self) else {
            return nil
        }
        return classType.init()
    }
}
