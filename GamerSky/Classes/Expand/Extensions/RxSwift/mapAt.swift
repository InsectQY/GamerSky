//
//  mapAt.swift
//  RxSwiftExt
//
//  Created by Michael Avila on 2/8/18.
//  Copyright © 2018 RxSwift Community. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension ObservableType {

    /**
     Returns an observable sequence containing as many elements as its input but all of them are mapped to the result at the given keyPath

     - parameter keyPath: A key path whose root type matches the element type of the input sequence
     - returns: An observable squence containing the values pointed to by the key path
     */
    public func mapAt<Result>(_ keyPath: KeyPath<E, Result>) -> Observable<Result> {
        return self.map { $0[keyPath: keyPath] }
    }
}

extension SharedSequenceConvertibleType {

    public func mapAt<Result>(_ keyPath: KeyPath<E, Result>) -> SharedSequence<SharingStrategy, Result> {
        return self.map { $0[keyPath: keyPath] }
    }
}
