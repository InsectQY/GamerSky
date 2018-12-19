//
//  KingfisherExtension.swift
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func qy_setImage(_ URLString: String?, placeholder placeHolderName: String? = nil, options: KingfisherOptionsInfo? = nil, progress: ((_ receivedSize: Int64, _ totalSize: Int64) -> ())? = nil, completionHandler: ((_ image: Image?, _ error: NSError?, _ cacheType: CacheType, _ imageURL: URL?) -> ())? = nil) {
        
        guard let URLString = URLString, let url = URL(string: URLString) else {return}
        
        let placeholder: UIImage? = placeHolderName == nil ? nil : UIImage(named: placeHolderName!)
        
        kf.setImage(with: url, placeholder: placeholder, options: options, progressBlock: { (receivedSize, totalSize) in
            progress?(receivedSize,totalSize)
        }) { (image, error, cacheType, imageURL) in
            completionHandler?(image, error, cacheType, imageURL)
        }
    }
}

extension UIButton {
    
    func qy_setBackgroundImage(_ URLString: String?, placeholder placeHolderName: String? = nil, options: KingfisherOptionsInfo? = nil, progress: ((_ receivedSize: Int64, _ totalSize: Int64) -> ())? = nil, completionHandler: ((_ image: Image?, _ error: NSError?, _ cacheType: CacheType, _ imageURL: URL?) -> ())? = nil) {
        
        guard let URLString = URLString, let url = URL(string: URLString) else {return}
        
        let placeholder: UIImage? = placeHolderName == nil ? nil : UIImage(named: placeHolderName!)
        
        kf.setBackgroundImage(with: url, for: state, placeholder: placeholder, options: nil, progressBlock: { (receivedSize, totalSize) in
            progress?(receivedSize,totalSize)
        }, completionHandler: { (image, error, cacheType, imageURL) in
            completionHandler?(image, error, cacheType, imageURL)
        })
    }
    
    func qy_setImage(_ URLString: String?, placeholder placeHolderName: String? = nil, options: KingfisherOptionsInfo? = nil, progress: ((_ receivedSize: Int64, _ totalSize: Int64) -> ())? = nil, completionHandler: ((_ image: Image?, _ error: NSError?, _ cacheType: CacheType, _ imageURL: URL?) -> ())? = nil) {
        
        guard let URLString = URLString, let url = URL(string: URLString) else {return}
        
        let placeholder: UIImage? = placeHolderName == nil ? nil : UIImage(named: placeHolderName!)
        
        kf.setImage(with: url, for: state, placeholder: placeholder, options: nil, progressBlock: { (receivedSize, totalSize) in
            progress?(receivedSize,totalSize)
        }, completionHandler: { (image, error, cacheType, imageURL) in
            completionHandler?(image, error, cacheType, imageURL)
        })
    }
}
