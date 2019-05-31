//
//  UIViewControllerExt.swift
//  RxSwiftX
//
//  Created by Pircate on 2018/5/2.
//  Copyright © 2018年 Pircate. All rights reserved.
//

import RxSwift
import RxCocoa
import SwiftyThirdParty

public extension Reactive where Base: UIViewController {
        
    func push(_ viewController: @escaping @autoclosure () -> UIViewController,
              animated: Bool = true)
        -> Binder<Void>
    {
        return Binder(base) { this, _ in
            this.navigationController?.pushViewController(viewController(), animated: animated)
        }
    }
    
    func pop(animated: Bool = true) -> Binder<Void> {
        return Binder(base) { this, _ in
            this.navigationController?.popViewController(animated: animated)
        }
    }
    
    func popToRoot(animated: Bool = true) -> Binder<Void> {
        return Binder(base) { this, _ in
            this.navigationController?.popToRootViewController(animated: animated)
        }
    }
    
    func present(_ viewController: @escaping @autoclosure () -> UIViewController,
                 animated: Bool = true,
                 completion: (() -> Void)? = nil)
        -> Binder<Void>
    {
        return Binder(base) { this, _ in
            this.present(viewController(), animated: animated, completion: completion)
        }
    }
    
    func dismiss(animated: Bool = true) -> Binder<Void> {
        return Binder(base) { this, _ in
            this.dismiss(animated: animated, completion: nil)
        }
    }

    var showError: Binder<Error> {

        return Binder(base) { vc, error in
//            vc.view.show(error.errorMessage)
        }
    }
}
