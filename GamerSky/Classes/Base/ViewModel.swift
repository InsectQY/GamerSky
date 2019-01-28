//
//  BaseViewModel.swift
//  QYNews
//
//  Created by Insect on 2019/1/21.
//  Copyright © 2019 Insect. All rights reserved.
//

import UIKit

class ViewModel {

    deinit {
        print("\(type(of: self)): Deinited")
    }
}

extension ViewModel: HasDisposeBag {}
