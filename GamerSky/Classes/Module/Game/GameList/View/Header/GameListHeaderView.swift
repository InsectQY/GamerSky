//
//  GameListHeaderView.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/26.
//Copyright © 2018年 engic. All rights reserved.
//

import UIKit

class GameListHeaderView: UICollectionReusableView, NibReusable {

    static let height: CGFloat = 44
    
    private var lastSelBtn = UIButton(type: .custom)
    
    // MARK: - IBOutlet
    @IBOutlet private weak var hotSortBtn: UIButton!
    @IBOutlet private weak var timeSortBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        sortBtnDidClick(hotSortBtn)
    }
    
    // MARK: - IBAction
    @IBAction private func sortBtnDidClick(_ sender: UIButton) {
        
        lastSelBtn.isSelected = false
        sender.isSelected = true
        lastSelBtn = sender
    }
}
