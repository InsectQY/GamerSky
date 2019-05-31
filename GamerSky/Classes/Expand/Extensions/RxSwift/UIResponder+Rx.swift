//
//  UIResponder+Rx.swift
//  RxSwiftX
//
//  Created by Pircate on 2018/5/25.
//  Copyright © 2018年 Pircate. All rights reserved.
//

import RxSwift
import RxCocoa

public extension Reactive where Base: UIResponder {
    
    var becomeFirstResponder: Binder<Void> {
        return Binder(base) { responder, _ in
            responder.becomeFirstResponder()
        }
    }
    
    var resignFirstResponder: Binder<Void> {
        return Binder(base) { responder, _ in
            responder.resignFirstResponder()
        }
    }
}
