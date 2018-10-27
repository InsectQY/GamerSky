//
//  KingfisherExtension.swift
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func qy_setImage(_ URLString: String?, _ placeHolderName: String? = nil,progress: ((_ receivedSize: Int64, _ totalSize: Int64) -> ())? = nil, completionHandler: ((_ image: Image?, _ error: NSError?, _ cacheType: CacheType, _ imageURL: URL?) -> ())? = nil) {
        
        guard let URLString = URLString else {return}
        
        guard let url = URL(string: URLString) else {return}
        
        guard let placeHolderName = placeHolderName else {
            
            kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: { (receivedSize, totalSize) in
                progress?(receivedSize,totalSize)
            }) { (image, error, cacheType, imageURL) in
                completionHandler?(image, error, cacheType, imageURL)
            }
            return
        }
        
        kf.setImage(with: url, placeholder: UIImage(named: placeHolderName), options: nil, progressBlock: { (receivedSize, totalSize) in
            progress?(receivedSize,totalSize)
        }) { (image, error, cacheType, imageURL) in
            completionHandler?(image, error, cacheType, imageURL)
        }
    }
    
    func qy_setImage(_ URLString: String?, _ placeHolderName: String? = nil) {
        
       qy_setImage(URLString, placeHolderName, progress: nil, completionHandler: nil)
    }
}

extension UIButton {
    
    func qy_setBackgroundImage(_ URLString: String?, _ placeHolderName: String? = nil, _ state:UIControl.State = .normal ,progress: ((_ receivedSize: Int64, _ totalSize: Int64) -> ())? = nil, completionHandler: ((_ image: Image?, _ error: NSError?, _ cacheType: CacheType, _ imageURL: URL?) -> ())? = nil) {
        
        guard let URLString = URLString else {return}
        
        guard let url = URL(string: URLString) else {return}
        
        guard let placeHolderName = placeHolderName else {
            
            kf.setBackgroundImage(with: url, for: state, placeholder: nil, options: nil, progressBlock: { (receivedSize, totalSize) in
                progress?(receivedSize,totalSize)
            }, completionHandler: { (image, error, cacheType, imageURL) in
                completionHandler?(image, error, cacheType, imageURL)
            })
            return
        }
    
        kf.setBackgroundImage(with: url, for: state, placeholder: UIImage(named: placeHolderName), options: nil, progressBlock: { (receivedSize, totalSize) in
            progress?(receivedSize,totalSize)
        }, completionHandler: { (image, error, cacheType, imageURL) in
            completionHandler?(image, error, cacheType, imageURL)
        })
    }

    func qy_setImage(_ URLString: String?, _ placeHolderName: String? = nil, _ state:UIControl.State = .normal ,progress: ((_ receivedSize: Int64, _ totalSize: Int64) -> ())? = nil, completionHandler: ((_ image: Image?, _ error: NSError?, _ cacheType: CacheType, _ imageURL: URL?) -> ())? = nil) {
        
        guard let URLString = URLString else {return}
        
        guard let url = URL(string: URLString) else {return}
        
        guard let placeHolderName = placeHolderName else {
            
            kf.setImage(with: url, for: state, placeholder: nil, options: nil, progressBlock: { (receivedSize, totalSize) in
                progress?(receivedSize,totalSize)
            }, completionHandler: { (image, error, cacheType, imageURL) in
                completionHandler?(image, error, cacheType, imageURL)
            })
            return
        }
        
        kf.setImage(with: url, for: state, placeholder: UIImage(named: placeHolderName), options: nil, progressBlock: { (receivedSize, totalSize) in
            progress?(receivedSize,totalSize)
        }, completionHandler: { (image, error, cacheType, imageURL) in
            completionHandler?(image, error, cacheType, imageURL)
        })
    }
}
