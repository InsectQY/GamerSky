//
//  UIView+Rx.swift
//  RxSwiftX
//
//  Created by Pircate on 2018/5/25.
//  Copyright © 2018年 Pircate. All rights reserved.
//

import RxSwift
import RxCocoa

public extension Reactive where Base: UIView {
    
    var endEditing: Binder<Bool> {
        return Binder(base) { view, force in
            view.endEditing(force)
        }
    }
    
    var originY: Binder<CGFloat> {
        return Binder(base) { view, y in
            view.frame.origin.y = y
        }
    }
}
