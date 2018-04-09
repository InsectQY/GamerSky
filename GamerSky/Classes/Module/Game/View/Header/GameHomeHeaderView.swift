//
//  GameHeaderView.swift
//  GamerSky
//
//  Created by Insect on 2018/4/9.
//  Copyright © 2018年 engic. All rights reserved.
//

import UIKit

class GameHomeHeaderView: BaseView {

    static let headerHeight: CGFloat = 130
    
    private lazy var collectionView: BaseCollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: ScreenWidth / 5, height: height)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        let collectionView = BaseCollectionView(frame: bounds, collectionViewLayout: flowLayout)
        collectionView.register(cellType: GameHomeHeaderCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(collectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UICollectionViewDataSource
extension GameHomeHeaderView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: GameHomeHeaderCell.self)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension GameHomeHeaderView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
